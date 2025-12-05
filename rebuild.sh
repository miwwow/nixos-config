#!/bin/sh
pushd ~/nixos-config
echo "Start Format"
nix fmt .
git --no-pager diff --minimal
echo "Rebuild NixOS"
sudo nixos-rebuild switch --flake .#
popd
