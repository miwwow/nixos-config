{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

  config = {
    networking.hostName = "nixos";
    networking.firewall.enable = true;
  };
}
