{
  lib,
  config,
  ...
}:
{
  config = {
    home-manager.users."mikuhatsune".programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          "layer" = "top";
          "modules-left" = [
            "hyprland/workspaces"
          ];
          "modules-center" = [ "clock" ];
          "modules-right" = [
            "network"
            "pulseaudio"
            "cpu"
            "memory"
          ];
          "mpd" = {
            "tooltip" = false;
            "format" = "{stateIcon} {artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
          };
          "pulseaudio" = {
            "tooltip" = false;
            "scroll-step" = 5;
            "format" = "{icon} {volume}%";
          };
          "network" = {
            "format-wifi" = "{icon} {signalStrength}%";
            "tooltip" = true;
            "tooltip-format-wifi" = "{essid} {ipaddr}";
            "tooltip-format-ethernet" = "{ipaddr}";
          };
          "cpu" = {
            "tooltip" = false;
            "format" = "CPU {}%";
          };
          "memory" = {
            "tooltip" = false;
            "format" = "MEM {}%";
          };
          "hyprland/workspaces" = {
            "format" = "<sub>{icon} {windows}</sub>";
            "format-window-separator" = "";
          };
          "clock" = {
            "format" = "{%H:%M}";
            "format-alt" = "{%d/%m/%y}";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              "mode" = "month";
            };
          };
        };
      };
    };
  };
}
