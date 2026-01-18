---
title: 'YubiKey based Full Disk Encryption on NixOS'
date: 2026-01-18T16:05:48+01:00
draft: true
tags: ["nix", "linux", "yubikey", "encryption", "security"]
cover:
    image: "YubiKey-5series.png"
    alt: "YubiKey 5 series lineup."
---

This article describes the setup process for YubiKey based Full Disk Encryption
(FDE) on NixOS. It uses the YubiKey as singe-factor authentication and
automatically decrypts the disk during boot without user interaction as long as
the key is plugged in.

*This is mostly intended as a quick guide for myself and my NixOS
configuration repository, it is **heavily** based on [this
wiki](https://wiki.nixos.org/wiki/Yubikey_based_Full_Disk_Encryption_(FDE)_on_NixOS)
which contains a more general guide.*

## Preparations

Boot the installation medium and set up the environment.

```sh
sudo -i
nix-shell https://github.com/sgillespie/nixos-yubikey-luks/archive/master.tar.gz
```

## Set up the YubiKey

1. **If not done already**, program the YubiKey's Configuration Slot 2 in
   Challenge-Response mode.

    ```sh
    ykpersonalize -2 -ochal-resp -ochal-hmac
    ```

2. Gather the initial salt.

    ```sh
    SALT="$(dd if=/dev/random bs=1 count=16 2>/dev/null | rbtohex)"
    ```

3. Calculate the initial challenge and response to the YubiKey, remember to plug
   it in first.

    ```sh
    CHALLENGE="$(echo -n $SALT | openssl dgst -binary -sha512 | rbtohex)"
    RESPONSE=$(ykchalresp -2 -x $CHALLENGE 2>/dev/null)
    ```

4. Generate the LUKS key.

    ```sh
    LUKS_KEY="$(echo | pbkdf2-sha512 64 1000000 $RESPONSE | rbtohex)"
    ```

5. Test if the key is programmed correctly, challenge the yubikey and check that
   the response is the expected response previously generated.

    ```sh
    ykchalresp -2 -x "$CHALLENGE"
    echo "$RESPONSE"
    ```

## Partitioning

Create a GPT partition table and two partitions on the target disk.

- Partition 1: This will be the EFI system partition: FAT32 etc., >512MB.
  - Or use existing boot partition if dual-booting with another OS that is
  already installed.
- Partition 2: This will be the LUKS-encrypted partition, aka the "LUKS device".

In the following we will use variables for identification, so set them to match
your partition setup:

```sh
EFI_PART=/dev/<efi_part>
LUKS_PART=/dev/<luks_part>
```

## Setup the LUKS device

1. Create the necessary filesystem on the efi system partition, and mount it.

    ```sh
    mkdir /mnt/boot
    mkfs.vfat -F 32 -n uefi "$EFI_PART" # Skip this if using pre-existing boot partition!
    mount "$EFI_PART" /mnt/boot
    ```

2. Store the salt and iteration count to the EFI systems partition.

    ```sh
    mkdir -p "$(dirname /mnt/boot/crypt-storage/default)"
    echo -ne "$SALT\n1000000" > /mnt/boot/crypt-storage/default
    ```

3. Create the LUKS device.

    ```sh
    echo -n "$LUKS_KEY" | hextorb | cryptsetup luksFormat --cipher=aes-xts-plain64 --key-size=512 --hash=sha512 --key-file=- "$LUKS_PART"
    ```

4. Open the LUKS device.

    ```sh
    echo -n "$LUKS_KEY" | hextorb | cryptsetup luksOpen "$LUKS_PART" encrypted --key-file=-
    ```

## LVM setup on the LUKS device

1. Setup the LUKS device as a physical volume.

    ```sh
    pvcreate /dev/mapper/encrypted
    ```

2. Setup a volume group on the LUKS device.

    ```sh
    vgcreate partitions /dev/mapper/encrypted
    ```

3. Setup two logical volumes on the LUKS device.

    - Volume 1: This will be the swap partition, choose an appropriate size.
    - Volume 2: This will be the root partition, rest of the free space.

    ```sh
    lvcreate -L 16G -n swap partitions
    lvcreate -l 100%FREE -n root partitions

    vgchange -ay # Activate volumes
    ```

4. Create the filesystems.

    ```sh
    mkswap -L swap /dev/partitions/swap
    mkfs.ext4 -L root /dev/partitions/root
    ```

## NixOS installation

1. Mount drives.

    ```sh
    umount "$EFI_PART"
    mount /dev/partitions/root /mnt
    mkdir /mnt/boot
    mount "$EFI_PART" /mnt/boot
    swapon /dev/partitions/swap
    ```

2. Generate (hardware) config.

    ```sh
    nixos-generate-config --root /mnt
    ```

3. Replace `/mnt/etc/nixos/configuration.nix` with this minimal config and
   replace all placeholders on the format <...> with appropriate values, there
   should be 5.

    ```nix
    { pkgs, ... }:
    {
      imports = [ ./hardware-configuration.nix ];

      boot = {
        initrd = {
          # Minimal list of modules to use the EFI system partition and the YubiKey
          kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];

          luks = {
            yubikeySupport = true;

            devices."encrypted" = {
              device = "<LUKS_PART>";

              yubikey = {
                slot = 2;
                twoFactor = false;
                gracePeriod = 30;
                keyLength = 64;
                saltLength = 16;
                storage = {
                  device = "<EFI_PART>";
                };
              };
            };
          };
        };

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };

      networking = {
        hostName = "<hostname>";
        networkmanager.enable = true;
      };

      users.users.<username> = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };

      environment.systemPackages = with pkgs; [
        vim
        git
      ];

      console.keyMap = "<keymap>"; # E.g. "sv-latin1"

      system.stateVersion = "23.11";
    }
    ```

4. Install NixOS.

    ```sh
    nixos-install
    ```

5. Set user password.

    ```sh
    nixos-enter --root /mnt -c 'passwd <username>'
    ```

6. Reboot.

    ```sh
    reboot
    ```

## Install full configuration

After rebooting, sign in to the user and do the following to install the full
system configuration.

1. Clone the configuration repository.

    ```sh
    eval "$(ssh-agent -s)" && ssh-add -K # Add ssh key from YubiKey, or use https
    git clone git@github.com:jonwin1/nixos-jonwin.git
    cd nixos-jonwin
    ```

2. Copy one of the host configurations or use an existing one.

    ```bash
    cp -r config/desktop config/<hostname>
    ```

3. Move hardware-configuration.nix into the repo.

    ```sh
    mv /etc/nixos/hardware-configuration.nix config/<hostname>/
    ```

4. Create an authorization mapping file for YubiKey login and sudo.

    ```sh
    nix-shell -p pam_u2f
    mkdir -p ~/.config/Yubico
    pamu2fcfg > ~/.config/Yubico/u2f_keys
    pamu2fcfg -n >> ~/.config/Yubico/u2f_keys # Add another YubiKey (optional)
    chmod 600 /home/jonwin/.config/Yubico/u2f_keys
    exit
    ```

5. Edit the configuration files as needed, e.g. add host in flake.nix:

    ```diff
    ...
      hosts = [
      ...
    +   {
    +     user = "<username>";
    +     hostname = "<hostname>";
    +     system = "x86_64-linux";
    +   }
      ];
    ...
    ```

6. Rebuild.

    ```sh
    git add .
    sudo nixos-rebuild switch --flake .#<hostname>
    ```

## Add additional keys (TODO)

## Remove lost key (TODO)

## Recovery

If the system is broken to the point of being unbootable, the disk can be
decrypted and accessed from a live system by following the below instructions.
If all keys for LUKS decryption are lost recovery is not possible.

1. Become root and setup the dependencies:

    ```sh
    sudo -i
    nix-shell https://github.com/sgillespie/nixos-yubikey-luks/archive/master.tar.gz
    ```

2. Set the partition variables:

    ```sh
    EFI_PART=/dev/<efi_part>
    LUKS_PART=/dev/<luks_part>
    ```

3. Get the challenge:

    ```sh
    mkdir /mnt/boot
    mount "$EFI_PART" /mnt/boot
    CHALLENGE=$(head -n1 /mnt/boot/crypt-storage/default | tr -d '\n' | openssl dgst -binary -sha512 | rbtohex)
    ```

4. Plug in the YubiKey and get its response to the challenge:

    ```sh
    RESPONSE=$(ykchalresp -2 -x $CHALLENGE 2>/dev/null)
    ```

5. Generate the LUKS key:

    ```sh
    LUKS_KEY="$(echo | pbkdf2-sha512 64 1000000 $RESPONSE | rbtohex)"
    ```

6. Unlock the LUKS device:

    ```sh
    echo -n "$LUKS_KEY" | hextorb | cryptsetup luksOpen $LUKS_PART encrypted --key-file=-
    ```

7. Mount the filesystem:

    ```sh
    mount /dev/partitions/root /mnt
    mkdir /mnt/boot
    mount "$EFI_PART" /mnt/boot
    ```

8. You can now enter the system or access the files within:

    ```sh
    nixos-enter
    ```
