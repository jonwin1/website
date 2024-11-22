---
title: 'Build package from Nixpkgs PR'
date: 2024-11-23T00:50:23+01:00
draft: false
---

This post aims to explain how to build and try packages from nixpkgs pull
requests. You could for example want to try a new package that has not been
merged yet or try some bug fixes.

There are multiple ways of doing this, below are two different methods. In both
cases we first need to clone nixpkgs and navigate into the directory

```
git clone git@github.com:NixOS/nixpkgs.git
cd nixpkgs
```

## nix-build

This approach is better if you want to install and use the package for a while.

To do this first checkout the PR branch replacing 123456 with the identifier
for the PR you want to try

```
git fetch upstream pull/123456/head; git checkout FETCH_HEAD
```

Now the package can be built with

```
nix-build -A package-name
```

This creates a link called result in the directory through which the application
can be launched, for example by

```
./result/bin/package-name
```

## nixpkgs-review

This approach is better for temporarily testing a package inside a nix-shell.

First install nixpkgs-review if it is not installed

```
nix-shell -p nixpkgs-review
```

Then simply run

```
nixpkgs-review pr 123456
```

replacing 123456 with the PR number.

The package can then be launched from inside the provided shell.

nixpkgs-review also provides some additional functionalities that are helpful
when reviewing packages. See [this
article](https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages) on the
NixOS wiki for more details about developing packages for Nix.

