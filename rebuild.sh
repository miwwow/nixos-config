#!bin/sh
pushd ~/nixos-config
nix fmt .
git --no-pager diff --minimal
sudo nixos-rebuild switch --flake .#
popd
