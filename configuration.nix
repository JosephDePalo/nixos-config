{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nixos/networking.nix
    ./nixos/desktop.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.groups.incus-admin = {};
  users.users."joe" = {
    isNormalUser = true;
    description = "Joseph";
    extraGroups = [ "networkmanager" "wheel" "incus-admin" ];
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
    initialPassword = "password";
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    git
    udiskie
    xdg-desktop-portal-hyprland
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  virtualisation.incus.enable = true;

  system.stateVersion = "26.05"; # DO NOT MODIFY
}
