---
title: 'Dwm (dynamic window manager)'
date: 2024-05-20T14:59:07+02:00
draft: true
cover:
    image: "dwm.png"
    alt: "Picture of my dwm"
    caption: ""
---

"dwm is an extremely fast, small, and dynamic window manager for X." -
[suckless.org](https://dwm.suckless.org/)

This post talks about my dwm configuration and the changes I have made to it. I
have installed quite a few patches and made some modifications of my own, I
have also added a flake.nix to make installation on NixOS really simple. You
can view the source code in my GitHub repository
[here](https://github.com/jonwin1/dwm-jonwin).

## Patches

Below is a list of all the patches I have installed with a short explanation of
each patch, press the links to view the patches on
[suckless.org](https://dwm.suckless.org/patches/).

- **[alwayscenter](https://dwm.suckless.org/patches/alwayscenter/):** "All
floating windows are centered, like the center patch, but without a rule."

- **[attachbottom](https://dwm.suckless.org/patches/attachbottom/):** "New
clients attach at the bottom of the stack instead of the top."

- **[center first
window](https://dwm.suckless.org/patches/center_first_window/):** Adds rule to
center window if it is the only client in a tag.

- **[cfacts](https://dwm.suckless.org/patches/cfacts/):** Provides the ability
to assign weights to clients to modify how the space in the stacks is
distributed between the clients.

- **[cursorwarp](https://dwm.suckless.org/patches/cursorwarp/):** "Warp the
cursor to the center of the target window when switching between them with
focusstack(), focusmon(), manage() and unmanage()"

- **[exitmenu](https://dwm.suckless.org/patches/exitmenu/):** "Simple exit menu
for dwm."

- **[hide vacant tags](https://dwm.suckless.org/patches/hide_vacant_tags/):**
"This patch prevents dwm from drawing tags with no clients (i.e. vacant) on the
bar."

- **[movestack](https://dwm.suckless.org/patches/movestack/):** "This plugin
allows you to move clients around in the stack and swap them with the master.
It emulates the behavior off mod+shift+j and mod+shift+k in Xmonad."

- **[resizecorners](https://dwm.suckless.org/patches/resizecorners/):** "By
default, windows can only be resized from the bottom right corner. With this
Patch, the mouse is warped to the nearest corner and you resize it from there."

- **[restartsig](https://dwm.suckless.org/patches/restartsig/):** Allows
restarting of dwm.

- **[scratchpad](https://dwm.suckless.org/patches/scratchpad/):** "The
scratchpad patch allows you to spawn or restore a floating terminal window. It
is usually useful to have one to do some short typing."

- **[splitstatus](https://dwm.suckless.org/patches/splitstatus/):** "This patch
replaces the standard statusbar items (window name to the right of the tags,
and status on the right) with two status items: one in the centre, and one on
the right."

- **[swallow](https://dwm.suckless.org/patches/swallow/):** Terminals swallow
windows opened by child processes.

- **[tilewide](https://dwm.suckless.org/patches/tilewide/):** "The tilewide
layout is a variant of the standard tile layout. Windows added to the master
area will be positioned side by side, instead of one on top of the other. This
makes better use of screen space on ultra wide monitors."

- **[viewontag](https://dwm.suckless.org/patches/viewontag/):** "Follow a
window to the tag it is being moved to."

### Other Changes

font

color

rules

XF86XK

keys

## Keybinds

#### Applications

- `Super + p`: Spawn dmenu
- `Super + Ret`: Spawn st
- `Super + s`: Spawn scratchpad
- `Super + b`: Spawn Bitwarden-menu
- `Super + w`: Spawn qutebrowser

#### Clients and Areas

- `Super + j`: Focus next client
- `Super + k`: Focus previous client
- `Super + i`: Increase number of master clients
- `Super + d`: Decrease number of master clients
- `Super + h`: Decrease master area size
- `Super + l`: Increase master area size
- `Super + Shift + h`: Increase client weight
- `Super + Shift + l`: Decrease client weight
- `Super + Shift + o`: Reset client weight
- `Super + Shift + j`: Swap client with next client
- `Super + Shift + k`: Swap client with previous client
- `Super + Shift + Space`: Toggle client to floating
- `Super + Shift + Return`: Zoom client to master area
- `Super + q`: Kill client

#### Layout

- `Super + t`: Set tilewide layout
- `Super + Shift + t`: Set tile layout
- `Super + f`: Set floating layout
- `Super + m`: Set monocle layout
- `Super + Space`: Toggle previous layout
- `Super + Shift + b`: Toggle the bar

#### Tags and Monitors

- `Super + Tab`: View previous tag
- `Super + 0`: View all tags
- `Super + Shift + 0`: Move client to all tags
- `Super + ,`: Focus previous monitor
- `Super + .`: Focus next monitor
- `Super + Shift ,`: Move client to previous monitor
- `Super + Shift .`: Move client to next monitor

- `Super + 1-9`: View tag 1-9
- `Super + Shift + 1-9`: Send client to tag 1-9
- `Super + Control + 1-9`: Add tag 1-9 to view
- `Super + Shift + Control + 1-9`: Add client to tag 1-9

#### Other

- `Super + Shift + q`: Open exit menu

## Install

### Dependencies

- libX11
- libXinerama
- libXft
- fira-code-nerdfont

### NixOS

Add this repo as a flake input in your flake.nix:

    inputs = {
        dwm = {
            url = "github:jonwin1/dwm-jonwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

Then add the following to your configuration.nix to enable dwm:

    services = {
        xserver = {
            windowManager.dwm = {
                enable = true;
                package = inputs.dwm.packages."x86_64-linux".default;
            };
        };
    };

#### Running dwm

### Other Distros

Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):

    make clean install

#### Running dwm

Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that
the DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

In order to display status info in the bar, you can do something
like this in your .xinitrc:

    while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    do
    	sleep 1
    done &
    exec dwm
