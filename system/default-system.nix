{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # Set timezone and fix RTC clock
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/London";
  };

  # Set default locales
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set Nvidia graphics drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  # Enable printing with CUPS
  services.printing.enable = true;

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.blacklistedKernelModules = [
    "hid-uclogic"
    "wacom"
    "wacomtablet"
    "kdePackages.wacomtablet"
    "rPackges.tablet"
  ];

  # TODO: switch to hyprland
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # TODO: move this to apps
  programs.firefox.enable = true;

  # Primary admin user
  users.users.mikuhatsune = {
    isNormalUser = true;
    description = "Hatsune Miku";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # TODO: move these to apps
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kget
      kdePackages.ktorrent
      krusader
      (discord.override {
        withVencord = true;
      })
      vscode
      krita
    ];
  };

  # TODO: move these to apps
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    bash
  ];

  system.autoUpgrade = {
    enable = true;
    flake = "github:miwwow/nixos-config";
  };

  system.stateVersion = "25.05";
}
