---
title: 'Yubikey SSH'
date: 2026-01-18T14:58:25+01:00
draft: false
tags: ["linux", "yubikey", "ssh", "git", "security"]
cover:
    image: "yubikey-ssh.png"
    alt: ""
    caption: ""
---

Quick guide for creating and using FIDO2 resident keys for ssh authentication.
Verified working on YubiKey 5 Series keys.

## Prerequisites

Make sure the ssh-agent is running:

```sh
eval "$(ssh-agent -s)"
```

## Generate a new ssh key on a YubiKey

```sh
ssh-keygen -t ed25519-sk -O resident -C "your_email@example.com"
```

## Temporarily add key to a computer

This adds the key to the ssh agent and it will continue working until the
computer is rebooted, after which it must be readded.

```sh
ssh-add -K
```

## Permanently add key to a computer

Adds a file in the users .ssh directory which points the ssh agent to the
key, this will always work if the key is plugged in.

```sh
ssh-keygen -K
mv id_ed25519_sk_rk ~/.ssh/id_ed25519_sk
```

