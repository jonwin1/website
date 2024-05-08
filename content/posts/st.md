---
title: 'St (simple terminal)'
date: 2024-05-08T16:57:11+02:00
draft: true
cover:
    image: "st.png"
    alt: "Image of st window"
---

"st is a simple terminal implementation for X" - [suckless.org](https://st.suckless.org/).

This is my configuration of the suckless terminal st. I have installed a few 
different patches and made some configuration changes to improve the usability
and look of the terminal. 

## Try My Config

To try my configuration on any system with Nix installed run the following:

    nix run github:jonwin1/st-jonwin

## Installing

### NixOS

Add the repository as an input in your flake.nix:

    inputs = {
        st = {
            url = "github:jonwin1/st-jonwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

Then add this to your configuration.nix to install st:

    environment = {
        systemPackages = with pkgs; [
            inputs.st.packages."${system}".default
        ];
    };

### Other distros

Edit config.mk to match your local setup (st is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install st (if
necessary as root):

    make clean install

#### Dependencies

- Xlib header files.
- FiraCode Nerd Font
- harfbuzz

**Note:** On NixOS dependencies are automatically installed. (Not the font)

## Patches

- [Srollback](https://st.suckless.org/patches/scrollback/)
    - st-scrollback-20210507-4536f46
    - st-scrollback-reflow-20230607-211964d
    - st-scrollback-mouse-20220127-2c5edf2
    - st-scrollback-mouse-altscreen-20220127-2c5edf2
- [Boxdraw](https://st.suckless.org/patches/boxdraw/)
    - st-boxdraw-v2-0.8.5
- [Alpha](https://st.suckless.org/patches/alpha/)
    - st-alpha-20220206-0.8.5
- [Alpha Focus Highlight](https://st.suckless.org/patches/alpha_focus_highlight/)
    - st-focus-20200731-patch_alpha
- [Ligatures](https://st.suckless.org/patches/ligatures/)
    - A combination of st-ligatures-alpha-scrollback-0.9
    and st-ligatures-boxdraw-0.9, see [st-ligatures-boxdraw-alpha-scrollback-2024-04-24-0.9.diff](./patches/st-ligatures-boxdraw-alpha-scrollback-2024-04-24-0.9.diff)
- [Visual bell 2](https://st.suckless.org/patches/visualbell2/)
    - st-visualbell2-basic-2020-05-13-045a0fa
    - st-visualbell2-enhanced-2020-05-13-045a0fa
- [Newterm](https://st.suckless.org/patches/newterm/)
    - st-newterm-0.9
- [Copyurl](https://st.suckless.org/patches/copyurl/)
    - st-copyurl-multiline-20230406-211964d
- [Open copied url](https://st.suckless.org/patches/open_copied_url/)
    - st-openclipboard-20220217-0.8.5

## Keybinds

- `alt + c`: Copy
- `alt + v`: Paste
- `alt + k`: Scroll up
- `alt + j`: Scroll down
- `alt + u`: Scroll up page
- `alt + d`: Scroll down page
- `alt + shift + k`: Zoom in
- `alt + shift + j`: Zoom out
- `alt + shift + h`: Zoom reset
- `alt + l`: Copy url above
- `alt + shift + l`: Copy url below
- `alt + o`: Open url in clipboard in default browser
- `alt + shift + return`: Spawn new terminal in current directory

Mouse wheel scrolling is also added.
