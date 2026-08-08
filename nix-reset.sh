#!/usr/bin/env bash

# remove all system profiles
sudo rm -f /nix/var/nix/profiles/system*
sudo rm -f /nix/var/nix/profiles/per-user/*/*

# clean up
sudo nix-collect-garbage -d

# rebuild from flake
sudo nixos-rebuild switch --flake ~/nixos-config
