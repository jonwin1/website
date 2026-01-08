---
title: "JWMenu: A Simple, Configurable Menu Runner"
date: 2026-01-08T16:25:54+01:00
draft: false
tags: ["rofi", "menu", "productivity", "nix", "linux"]
---

JWMenu is a small, configurable menu runner built on top of rofi. It is designed
to be easy to configure by using TOML configuration files instead of relying on
long scripts with hardcoded options. You can create **nested submenus**, assign
commands to entries, or even have multi-line commands.

This makes it ideal for things like:

- System menus
- Power menus
- Quick options and toggles

…and anything else you can imagine that fits into a hierarchical menu.

### Why I Made It

The idea for this project originally came from wanting to create my own system
menu similar to [the one in
Omarchy](https://github.com/basecamp/omarchy/blob/fe48a16a906500924a351a036ad5c4eb93661044/bin/omarchy-menu).
But it relies on a long bash script and a large collection of helper
scripts which makes it difficult to modify and adapt to work as I want. Instead
i wanted something that was:

- **Easy to edit:** I didn’t want to dive into dozens of Bash scripts just to
add a new item.
- **Flexible:** Each menu entry can be a command or another submenu, with
arbitrary levels of nesting.
- **Lightweight:** Minimal runtime dependencies, so it runs anywhere rofi runs.

In short, I wanted something simple to set up, easy to maintain, and still powerful.

### Key Features

- Nested menus with arbitrary depth
- Declarative configuration in TOML
- Supports multiple independent menus via separate files
- Minimal dependencies: just rofi and a C17 compiler

JWMenu can be installed and run on **Nix-based systems** or built manually on
other Linux distributions.

### Try It Out

You can explore JWMenu on GitHub:
[https://github.com/jonwin1/jwmenu](https://github.com/jonwin1/jwmenu)

I’ve included some example menus to help you get started quickly. Whether you
want a simple launcher or a full-featured system menu, JWMenu makes it easy to
organize your workflow in rofi.

### Acknowledgements

JWMenu is built on top of [rofi](https://github.com/davatorium/rofi) and uses
[tomlc17](https://github.com/cktan/tomlc17) for parsing TOML.
