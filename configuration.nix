{ config, lib, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  };
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = true;
  };

  # Configure Peripherals & Radios
  networking = {
    hostName = "jdnix";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Core Services
  services.xserver = {
    enable = true;
    windowManager.qtile = {
      enable = true;
    };
    displayManager.lightdm = {
      enable = true;
      background = /home/joe/.wallpaper;
    };
    xkb.layout = "us";
  };

  services.printing.enable = true; # Enable CUPS
  services.blueman.enable = true; # Bluetooth Manager
  networking.firewall.enable = true; # Nix Firewall
  services.openssh.enable = true; # sshd
  services.udisks2.enable = true; # Automounter
  services.gvfs.enable = true;
  

  # Define Users
  users.users.joe = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
    initialPassword = "password";
  };


  home-manager.users.joe = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      keepassxc
      spotify
      obsidian
      btop
      bat
      eza
      procs
      ripgrep
      flameshot
    ];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        set -o vi
      '';
      shellAliases = {
        nix_build = "sudo nixos-rebuild switch";
      };
      localVariables = {
        EDITOR = "vim";
      };
    };
    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono";
      extraConfig = ''
        include /home/joe/.cache/wal/colors-kitty.conf
        background_opacity 0.95
      '';
    };
    programs.starship.enable = true;
    programs.zathura.enable = true;
    programs.zathura.extraConfig = "include /home/joe/.cache/wal/zathurarc";
    programs.vscode.enable = true;
    programs.ranger = {
      enable = true;
      extraConfig = ''
        set preview_images true
        set preview_images_method kitty
      '';
    };
    home.stateVersion = "24.11";

    services.dunst = {
      enable = true;
      configFile = /home/joe/.cache/wal/dunstrc;
    };

    programs.rofi = {
      enable = true;
      theme = /home/joe/.cache/wal/colors-rofi-dark.rasi;
    };

    xdg.configFile."qtile/config.py".source = /home/joe/Configs/qtile/config.py;
    services.polybar.config = /home/joe/Configs/polybar/config.ini;

  };

  # Configure packages.
  nixpkgs.config.allowUnfree = true;

  services.picom = {
    enable = true;
    shadow = true;
    shadowExclude = [
      "class_g = 'Polybar'"
    ];
    fade = true;
    fadeSteps = [ 0.04 0.04 ];
    settings = {
      corner-radius = 15.0;
    };
  };

  programs.firefox.enable = true;
  programs.light.enable = true; # Maybe enable brightnessKeys?

  environment.systemPackages = with pkgs; [
    # CLI Uitilities
    vim
    neofetch
    curl
    pulsemixer
    procs
    git
    openvpn
    nfs-utils
    libnotify
    feh
    # UI/UX
    polybar
    pywal
    rofi
    # Services
    udiskie
    usbutils
    xss-lock
    betterlockscreen
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];  

  # Miscellaneous
  system.copySystemConfiguration = true; # Backup System Configuration
  system.stateVersion = "24.11"; # DO NOT MODIFY

}

