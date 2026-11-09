# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ 
    "nix-command"
    "flakes"
  ];

  boot.loader = {
      grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      gfxmodeEfi = "2560x1600";
      gfxpayloadEfi = "keep";
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "empty-sekai";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  # Use Sway as the window manager.
  programs.sway.enable = true;

  services.xserver.enable = false;
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "sway";
  services.displayManager.sessionPackages = [ pkgs.sway ];
  services.desktopManager.gnome.enable = false;
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;

  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = "1"; }
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.hatsunemiku = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    kitty
    vscodium
    vim
    wget
    brightnessctl
  ];

  system.stateVersion = "26.05";
}
