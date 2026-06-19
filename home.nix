{ inputs, config, pkgs, ... }:

{
  home.username = "joe";
  home.homeDirectory = "/home/joe";

  home.stateVersion = "26.05";

  # Packages (user-level apps)
  home.packages = with pkgs; [
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

  # Git config
  programs.git = {
    enable = true;
    settings.user.name = "Joseph DePalo";
    settings.user.email = "joe.dee13@outlook.com";
  };

  programs.fzf = {
    enable = true;
  
    enableZshIntegration = true;
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      bindkey -e
      eval "$(zoxide init zsh)"

      autoload -Uz colors && colors
      setopt PROMPT_SUBST
      PROMPT='%F{cyan}%n%f@%F{blue}%m%f:%F{yellow}%~%f %# '

      function calc { python -c "print($*)" }
      function srch {
        if [ -v 1 ]; then
          name=$(fzf -e --walker-root $1 --preview='bat --color=always {}')
        else
          name=$(fzf -e --preview='bat --color=always {}')
        fi
        [[ ! -z "$name" ]] && $EDITOR $name
      }
    '';
    shellAliases = {
      ls = "eza --hyperlink";
      vim = "$EDITOR";
      e = "$EDITOR";
      confs = "srch $CFGDIR";
      build = "sudo nixos-rebuild switch --flake $CFGDIR#$HOST";
      try = "nix-shell -p";
      temp = "export TEMP=$(mktemp -d); cd $TEMP";
    };
    localVariables = {
      EDITOR = "nvim";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Adwaita-dark";
    CFGDIR = "/home/joe/nixos-config";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # Colorscheme
      gruvbox-nvim

      # UI
      nvim-web-devicons
      bufferline-nvim
      bufdelete-nvim

      # File navigation
      nvim-tree-lua
      telescope-nvim
      plenary-nvim

      # LSP
      nvim-lspconfig

      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      lspkind-nvim

      # Treesitter (grammars pre-compiled by nix)
      nvim-treesitter.withAllGrammars

      # Formatting
      conform-nvim

      # Git
      gitsigns-nvim
      lazygit-nvim

      # Utils
      nvim-autopairs
      which-key-nvim
    ];

    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      pyright
      nixd

      # Formatters
      stylua
      black
      prettier
      tex-fmt

      # Tools
      lazygit
    ];
  };

  xdg.configFile."nvim/init.lua".source = ./dotfiles/nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./dotfiles/nvim/lua;

  programs.firefox = {
    enable = true;
    profiles = {
      clean = {
        id = 1;
        name = "clean";
      };
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          darkreader
          vimium
          clearurls
        ];
        settings = {
          "app.normandy.api_url" = "";
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.update.auto" = false;
          "beacon.enabled" = false;
          "breakpad.reportURL" = "";
          "browser.aboutConfig.showWarning" = false;
          "browser.cache.offline.enable" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.disableResetPrompt" = true;
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.introShown" = true;
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.selfsupport.url" = "";
          "browser.send_pings" = false;
          "browser.sessionstore.privacy_level" = 0;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "device.sensors.ambientLight.enabled" = false;
          "device.sensors.enabled" = false;
          "device.sensors.motion.enabled" = false;
          "device.sensors.orientation.enabled" = false;
          "device.sensors.proximity.enabled" = false;
          "dom.battery.enabled" = false;
          "dom.private-attribution.submission.enabled" = false;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "extensions.getAddons.cache.enabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.pocket.enabled" = false;
          "extensions.shield-recipe-client.api_url" = "";
          "extensions.shield-recipe-client.enabled" = false;
          "extensions.webservice.discoverURL" = "";
          "media.autoplay.default" = 0;
          "media.autoplay.enabled" = true;
          "media.eme.enabled" = false;
          "media.gmp-widevinecdm.enabled" = false;
          "media.navigator.enabled" = false;
          "media.peerconnection.enabled" = false;
          "media.video_stats.enabled" = false;
          "network.allow-experiments" = false;
          "network.captive-portal-service.enabled" = false;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "network.trr.mode" = 5;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.query_stripping" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.pbmode.enabled" = true;
          "privacy.usercontext.about_newtab_segregation.enabled" = true;
          "security.ssl.disable_session_identifiers" = true;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
          "signon.autofillForms" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.cachedClientID" = "";
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "webgl.disabled" = true;
          "webgl.renderer-string-override" = " ";
          "webgl.vendor-string-override" = " ";
        };
      };
    };
  };
}
