{
  pkgs,
  ...
}:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;

        gfxmodeEfi = "2560x1440";
        gfxpayloadEfi = "keep";
        milk-theme.enable = true;
      };
      timeout = null;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
