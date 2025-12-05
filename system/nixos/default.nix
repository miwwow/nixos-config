{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

  config = {
    networking.hostName = "nixos";
    networking.firewall.enable = true;

    desktop.hyprland.monitors = [
      "eDP-1, 2560x1600@165, 0x0, 1"
      "HDMI-A-1, preferred, auto-left, 1"
    ];
  };
}
