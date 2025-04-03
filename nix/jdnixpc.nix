{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "jdnixpc";
  boot.loader.grub.efiInstallAsRemovable = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
  };
  services.xserver.screenSection = ''
    Option "metamodes" "3440x1440_165 +0+0"
  '';
}
