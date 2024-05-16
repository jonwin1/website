---
title: 'Keyboard Layouts'
date: 2024-05-16T15:15:51+02:00
draft: false
cover:
    image: "/keyboard/lg-v4.5.jpg"
    alt: "TKL keyboard with keys removed and moved around"
    caption: ""
---

My many attempts at creating a more optimal keyboard layout for my self. So far
all of the layouts have been used on a normal TKL keyboard, but with the latest
layouts the goal has been to create a layout that would work on a
[Charybdis](https://bastardkb.com/product/charybdis-kit/) by Bastard Keyboards.
See the cover picture for how the keys have been moved around to make the
latest layout work on a normal keyboard.

The layouts have been configured using
[KMonad](https://github.com/kmonad/kmonad) which allows you to rebind all keys
on almost any keyboard and add extra functionalities such as multiple layers
and tap-hold buttions. My current layout is configured with KMonad through my
NixOS configuration and can be seen
[here](https://github.com/jonwin1/nixos-jonwin/blob/main/modules/kmonad.nix).

Below follows some of the different layouts I have tried and some thoughts
about them. They are ordered with the most recent version at the top so to get
the complete picture maybe start from the bottom.

## v4.5

{{<figure src="/keyboard/keyboard-v4.5.jpg" alt="Keyboard v4.5 image" align="center">}}

My current layout with three layers:
- A normal layer with letters, numbers, etc.
- A shift layer with capital letters, symbols, etc.
- A third layer (called nav in the image) with arrow keys, media keys, symbols,
F keys, etc.

The modifier keys have been placed on the thumb keys and the symbols on the
number keys closely resembles a normal US layout with some modification.

The upper left on each key is the normal layer, upper right is the shift layer,
lower right is the third layer and lower left is if the key is held down. The
keys M1, M2 and M3 are the mouse keys (left click, right click and middle
click).

## v4.2

{{<figure src="/keyboard/keyboard-v4.2.jpg" alt="Keyboard v4.2 image" align="center">}}

A slightly better thumb key layout but I tried something new with the symbols
on the number keys which I didn't like.

## v4.1

{{<figure src="/keyboard/keyboard-v4.1.jpg" alt="Keyboard v4.1 image" align="center">}}

A more complete layout for the Charybdis. The main issue with this one is that
I found that there are too many functions on the thumb keys and the numbers
maybe don't need to be in two places.

## v4.0

{{<figure src="/keyboard/keyboard-v4.0.jpg" alt="Keyboard v4.0 image" align="center">}}

This is where I had found the
[Charybdis](https://bastardkb.com/product/charybdis-kit/) keyboard and got
interested in maybe building one at some point. I am not going to make many
comments about this layout since it is just a first draft that I didn't use for
long.

I had an idea to place all brackets with opening and closing mirrored on the
two halves inspired by [The
Primeagen](https://github.com/ThePrimeagen/keyboards), but ended up not liking
that.

## v3.2

{{<figure src="/keyboard/keyboard-v3.2.jpg" alt="Keyboard v3.2 image" align="center">}}

Here I switched to using the Miryoku KMonad layout with some modifications such
as adding the keys å, ä and ö. I used this layout for multiple months and liked
it, it would work very well for a keyboard like the [5 column
Corne](https://typeractive.xyz/pages/build) keyboard.

The reason that I switched from this layout is that I felt like I needed a few
more keys because for example the letters ä and å are placed in a suboptimal
position which gets annoying when typing in swedish. I also ended up deciding
that I don't want homerow mods because I end up with misclicks sometimes.

By this point I where really sold on the idea of thumb keys so moving some
modifier keys to the thumbs could be a good idea and maybe reducing the number
of layers if I have more keys available.

## v3.0

{{<figure src="/keyboard/keyboard-v3.0.jpg" alt="Keyboard v3.0 image" align="center">}}

A half complete layout inspired by the
[Miryoku](https://github.com/manna-harbour/miryoku) layout and the [Miryoku
KMonad](https://github.com/manna-harbour/miryoku_kmonad) project.

## v2.0

{{<figure src="/keyboard/keyboard-v2.0.jpg" alt="Keyboard v2.0 image" align="center">}}

Some further improvements by trying some different placements of the backspace,
return, tab and escape keys. Also quite a few changes to the numbers and
symbols layers.

## v1.4

{{<figure src="/keyboard/keyboard-v1.4.jpg" alt="Keyboard v1.4 image" align="center">}}

This layout solves the issue with the modifier keys by using homerow mods, a
good idea that I used for a long time but didn't end up liking in the end. This
layout also adds another layer with the arrow keys for example and I started
trying the colemak-dh layout for the letters.

## v1.0

{{<figure src="/keyboard/keyboard-v1.0.jpg" alt="Keyboard v1.0 image" align="center">}}

This was the first layout I created by moving most of the symbols and numbers
to a separate layer under the letters, this layer was accessed by holding the
spacebar. The main issue with this was that keys such as backspace and escape
are still difficult to reach and the modifier keys requires a lot of movement
of the pinky finger.
