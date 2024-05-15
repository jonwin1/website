---
title: 'St (simple terminal)'
date: 2024-05-15T19:06:32+02:00
draft: false
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

## Patches

- [Srollback](https://st.suckless.org/patches/scrollback/): Allow scrolling back
through the terminal output using keybinds or the mouse wheel.
    - st-scrollback-20210507-4536f46
    - st-scrollback-reflow-20230607-211964d
    - st-scrollback-mouse-20220127-2c5edf2
    - st-scrollback-mouse-altscreen-20220127-2c5edf2
- [Boxdraw](https://st.suckless.org/patches/boxdraw/): Custom rendering of some
characters for drawing of boxes etc. with gapless alignment.
    - st-boxdraw-v2-0.8.5
- [Alpha](https://st.suckless.org/patches/alpha/)
    - st-alpha-20220206-0.8.5
- [Alpha Focus Highlight](https://st.suckless.org/patches/alpha_focus_highlight/)
    - st-focus-20200731-patch_alpha
- [Ligatures](https://st.suckless.org/patches/ligatures/): Adds proper drawing of ligatures.
    - A combination of st-ligatures-alpha-scrollback-0.9
    and st-ligatures-boxdraw-0.9, see [st-ligatures-boxdraw-alpha-scrollback-2024-04-24-0.9.diff](https://github.com/jonwin1/st-jonwin/blob/main/patches/st-ligatures-boxdraw-alpha-scrollback-2024-04-24-0.9.diff)
- [Visual bell 2](https://st.suckless.org/patches/visualbell2/): Adds a small 
visual bell in the top right of the terminal.
    - st-visualbell2-basic-2020-05-13-045a0fa
    - st-visualbell2-enhanced-2020-05-13-045a0fa
- [Newterm](https://st.suckless.org/patches/newterm/): Allows spawning a new st
terminal with the same working directory as the current st instance.
    - st-newterm-0.9
- [Copyurl](https://st.suckless.org/patches/copyurl/): Allows copying URLs from
the terminal with keybinds.
    - st-copyurl-multiline-20230406-211964d
- [Open copied url](https://st.suckless.org/patches/open_copied_url/): Allows opening
a url from the clipboard in a browser.
    - st-openclipboard-20220217-0.8.5

### Other Changes

I have changed the font to FiraCode Nerd Font to add support for ligatures and
nerd font icons. I have also changed the colors to colors from the [Nord theme](https://www.nordtheme.com/).

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

## Installing

### Dependencies

- libX11
- libXft
- libXinerama
- harfbuzz
- fira-code-nerdfont

**Note:** On NixOS dependencies are automatically installed.

### NixOS

Add the repository as an input in your flake.nix:

    inputs = {
        st = {
            url = "github:jonwin1/st-jonwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

Then add this to your configuration.nix:

    environment = {
        systemPackages = with pkgs; [
            inputs.st.packages."${system}".default
        ];
    };

Rebuild, switch and then you are done.

To update to a new version of the config just update the flake lock:

    nix flake lock --update-input st

### Other distros

This should work for most other linux distrubituions and is taken from the 
st [README](https://git.suckless.org/st/file/README.html).

Edit config.mk to match your local setup (st is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install st (if
necessary as root):

    make clean install

