{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  unstablepkgs = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
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

  disabledModules = ["services/misc/ollama.nix"];

  imports = ["${inputs.nixpkgs-unstable}/nixos/modules/services/misc/ollama.nix"];

  nixpkgs.config.cudaSupport = true;
  #  services.ollama = {
  #    package = unstablepkgs.ollama;
  #    enable = true;
  #    acceleration = "cuda";
  #  };
}
