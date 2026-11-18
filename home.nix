{
  config,
  lib,
  nur,
  pkgs,
  ...
}:
{
  home.username = "hatsunemiku";
  home.homeDirectory = "/home/hatsunemiku";
  home.stateVersion = "26.05";

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      keybindings = {
        "${modifier}+Return" = "exec kitty";
        "${modifier}+d" = "exec wofi --show drun";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+l" = "exec swaylock -f";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -b 'Yes, exit' 'swaymsg exit'";
        "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Down" = "move down";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+f" = "fullscreen";
        "${modifier}+space" = "floating toggle";

        "${modifier}+r" = "mode resize";

        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";

        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
      };
      startup = [
        {
          command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          always = true;
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "systemctl --user restart mako";
          always = true;
        }
      ];
    };
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        output.criteria = "eDP-1";
        output.mode = "2560x1600@165Hz";
        output.scale = 1.5;
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "DP-1";
            mode = "1920x1080@180Hz";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      }
    ];
  };

  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
    };
    settings = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      gpg.format = "ssh";
      user = {
        name = "miwwow";
        email = "admin@mirror.gay";
      };
    };
    includes = [
      {
        condition = "gitdir:~/university/";
        contents = import ./university-git.nix;
      }
    ];
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
    profiles = {
      default = {
        search.default = "ddg";
        search.engines = {
          nixpkgs = {
            name = "Nixpkgs";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            proton-pass
          ];
        };
      };
    };
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = true;
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    waybar
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    wofi
    mako
    grim
    slurp
    polkit_gnome
    kanshi
    clojure
    rlwrap
    jdk
  ];
}
