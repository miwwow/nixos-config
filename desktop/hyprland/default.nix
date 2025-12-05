{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ];

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
  };
}
