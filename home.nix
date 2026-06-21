{ inputs, config, pkgs, ... }:

{
  imports = [
    ./home/zsh.nix
    ./home/neovim.nix
    ./home/firefox.nix
  ];

  home.username = "joe";
  home.homeDirectory = "/home/joe";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    virt-viewer
    upower
    libnotify
    hyprlock
    bat
    python3
    bluetui
    claude-code
    dconf
    eza
    fd
    hypridle
    jq
    keepassxc
    kitty
    mako
    mpv
    pulsemixer
    procs
    ripgrep
    brightnessctl
    rofi
    spotify
    tldr
    tree
    unzip
    waybar
    zathura
    zoxide
    adw-gtk3
    papirus-icon-theme
    bibata-cursors
    grim
    satty
    slurp
  ];

  programs.git = {
    enable = true;
    settings.user.name = "Joseph DePalo";
    settings.user.email = "joe.dee13@outlook.com";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    CFGDIR = "/home/joe/nixos-config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  dconf.enable = true;
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "Papirus-Dark";
    cursor-theme = "Bibata-Modern-Ice";
    font-name = "JetBrainsMono Nerd Font 11";
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };

  home.file.".config/tmux/tmux.conf".source = ./dotfiles/tmux/tmux.conf;

  home.file.".local/bin/battery-watch" = {
    source = ./scripts/battery-watch.sh;
    executable = true;
  };
}
