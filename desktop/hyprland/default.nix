{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./waybar
  ];

  options = with lib; {
    desktop.hyprland = {
      monitors = mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };
  };

  config = {
    programs.hyprland.enable = true;
    home-manager.users."mikuhatsune".wayland.windowManager.hyprland.enable = true;
    home-manager.users."mikuhatsune" = {
      imports = [ ];
    };

    home-manager.users."mikuhatsune".wayland.windowManager.hyprland.settings = {
      input = {
        kb_layout = "us";
      };

      monitor = config.desktop.hyprland.monitors;

      bind = [
        "$mod, Q, killactive,"
      ];
    };
  };
}
