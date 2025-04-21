{
  config,
  lib,
  pkgs,
  inputs,
  cfgdir,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  boot.tmp.cleanOnBoot = true;

  # Configure Peripherals & Radios
  networking.networkmanager.enable = true;

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
      background = "${inputs.self}/Wallpaper";
      greeters.gtk.enable = true;
      greeters.gtk.theme.name = "Obsidian-2";
      greeters.gtk.theme.package = pkgs.theme-obsidian2;
    };
    xkb.layout = "us";
    xkb.options = "caps:swapescape";
  };

  services.printing.enable = true; # Enable CUPS
  services.blueman.enable = true; # Bluetooth Manager
  networking.firewall.enable = true; # Nix Firewall
  services.openssh.enable = true; # sshd
  services.udisks2.enable = true; # Automounter
  services.gvfs.enable = true; # Automounter helper
  documentation.man.generateCaches = true; # Search Man Pages

  environment.variables = {
    PATH = [
      "${cfgdir}/scripts"
    ];
    CFGDIR = cfgdir;
    NIXPKGS_ALLOW_INSECURE = 1;
  };

  # Define Users
  users.users.joe = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "networkmanager" "docker"];
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
    initialPassword = "password";
  };

  # Configure packages.
  services.picom = {
    enable = true;
    shadow = true;
    shadowExclude = [
      "class_g = 'Polybar'"
    ];
    fade = true;
    fadeSteps = [0.04 0.04];
    settings = {
      corner-radius = 15.0;
    };
  };

  programs.light.enable = true; # Maybe enable brightnessKeys?
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # CLI Uitilities
    neofetch
    curl
    pulsemixer
    procs
    git
    openvpn
    nfs-utils
    libnotify
    feh
    file
    pinentry-curses
    pass
    man-pages
    man-pages-posix
    # UI/UX
    (polybar.override {pulseSupport = true;})
    pywal
    rofi
    theme-obsidian2
    xclip
    # Services
    udiskie
    usbutils
    xss-lock
    betterlockscreen
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # Miscellaneous
  system.stateVersion = "24.11"; # DO NOT MODIFY
}
