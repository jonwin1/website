---
title: 'YubiKey'
date: 2026-01-16T13:44:48+01:00
draft: true
cover:
    image: "YubiKey-5series.png"
    alt: ""
    caption: ""
---

## SSH

1. Make sure the ssh-agent is running

    ```sh
    eval "$(ssh-agent -s)"
    ```

2. Generate a new ssh key on a YubiKey

    ```sh
    ssh-keygen -t ed25519-sk -O resident -C "your_email@example.com"
    ```

3. Temporarily add key to a computer

    ```sh
    ssh-add -K
    ```

4. Permanently add key to a computer

    ```sh
    ssh-keygen -K
    mv id_ed25519_sk_rk ~/.ssh/id_ed25519_sk
    ```
