{ ... }:
{
  home = {
    username = "mikuhatsune";
    homeDirectory = "/home/mikuhatsune";
  };

  programs.home-manager.enable = true;

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
