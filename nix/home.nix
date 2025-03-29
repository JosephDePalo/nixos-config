{ pkgs, inputs, config, ... }:
{
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
      pywalfox-native
      dconf
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
        ls = "eza";
        vim = "nvim";
      };
      localVariables = {
        EDITOR = "nvim";
      };
    };

    programs.git = {
      enable = true;
      userName = "Joseph DePalo";
      userEmail = "jdepalo@proton.me";
    };

    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-surround
        syntastic
        nerdtree
      ];
      coc.enable = true;
      extraConfig = ''
      	set notermguicolors
	set ls=0
        set expandtab autoindent tabstop=2 shiftwidth=2
      '';
    };

    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono";
      extraConfig = ''
        include ~/.cache/wal/colors-kitty.conf
        background_opacity 0.95
      '';
      settings = {
        enable_audio_bell = false;
      };
    };

    programs.starship.enable = true;
    programs.zathura.enable = true;
    programs.zathura.extraConfig = "include ${config.home.homeDirectory}/.cache/wal/zathurarc";
    programs.ranger = {
      enable = true;
      extraConfig = ''
        set preview_images true
        set preview_images_method kitty
      '';
    };

    services.dunst = {
      enable = true;
      configFile = inputs.self + "/.cache/wal/dunstrc";
    };

    programs.rofi = {
      enable = true;
      theme = inputs.self + "/.cache/wal/colors-rofi-dark.rasi";
    };

    services.polybar.config = inputs.self + "/configs/polybar/config.ini";

    xdg.configFile."qtile/config.py".source = inputs.self + "/configs/qtile/config.py";

    home.file.".config/wal/templates".source = inputs.self + "/configs/wal/templates";

    programs.vscode = {
      enable = true;
          extensions = with pkgs.vscode-extensions; [
            ms-vscode-remote.remote-ssh
            ms-python.python
            ms-python.pylint
            ms-python.debugpy
            github.copilot
            github.copilot-chat
            vscodevim.vim
          ];
    };
    gtk = {
      enable = true;
      theme.package = pkgs.theme-obsidian2;
      theme.name = "Obsidian-2";
    };

    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
#          search.default = "ddg";
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            ublock-origin
            darkreader
            vimium
            clearurls
            pywalfox
          ];
          settings = {
            "app.normandy.api_url" =  "";
            "app.normandy.enabled" =  false;
            "app.shield.optoutstudies.enabled" =  false;
            "app.update.auto" =  false;
            "beacon.enabled" =  false;
            "breakpad.reportURL" =  "";
            "browser.aboutConfig.showWarning" =  false;
            "browser.cache.offline.enable" =  false;
            "browser.crashReports.unsubmittedCheck.autoSubmit" =  false;
            "browser.crashReports.unsubmittedCheck.autoSubmit2" =  false;
            "browser.crashReports.unsubmittedCheck.enabled" =  false;
            "browser.disableResetPrompt" =  true;
            "browser.newtab.preload" =  false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" =  false;
            "browser.newtabpage.enhanced" =  false;
            "browser.newtabpage.introShown" =  true;
            "browser.safebrowsing.appRepURL" =  "";
            "browser.safebrowsing.blockedURIs.enabled" =  false;
            "browser.safebrowsing.downloads.enabled" =  false;
            "browser.safebrowsing.downloads.remote.enabled" =  false;
            "browser.safebrowsing.downloads.remote.url" =  "";
            "browser.safebrowsing.enabled" =  false;
            "browser.safebrowsing.malware.enabled" =  false;
            "browser.safebrowsing.phishing.enabled" =  false;
            "browser.selfsupport.url" =  "";
            "browser.send_pings" =  false;
            "browser.sessionstore.privacy_level" =  0;
            "browser.shell.checkDefaultBrowser" =  false;
            "browser.startup.homepage_override.mstone" =  "ignore";
            "browser.tabs.crashReporting.sendReport" =  false;
            "browser.urlbar.groupLabels.enabled" =  false;
            "browser.urlbar.quicksuggest.enabled" =  false;
            "browser.urlbar.speculativeConnect.enabled" =  false;
            "browser.urlbar.trimURLs" =  false;
            "datareporting.healthreport.service.enabled" =  false;
            "datareporting.healthreport.uploadEnabled" =  false;
            "datareporting.policy.dataSubmissionEnabled" =  false;
            "device.sensors.ambientLight.enabled" =  false;
            "device.sensors.enabled" =  false;
            "device.sensors.motion.enabled" =  false;
            "device.sensors.orientation.enabled" =  false;
            "device.sensors.proximity.enabled" =  false;
            "dom.battery.enabled" =  false;
            "dom.private-attribution.submission.enabled" =  false;
            "dom.webaudio.enabled" =  false;
            "experiments.activeExperiment" =  false;
            "experiments.enabled" =  false;
            "experiments.manifest.uri" =  "";
            "experiments.supported" =  false;
            "extensions.getAddons.cache.enabled" =  false;
            "extensions.getAddons.showPane" =  false;
            "extensions.pocket.enabled" =  false;
            "extensions.shield-recipe-client.api_url" =  "";
            "extensions.shield-recipe-client.enabled" =  false;
            "extensions.webservice.discoverURL" =  "";
#            "general.useragent.override" =  "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0 Gecko/20100101 Firefox/136.";
            "media.autoplay.default" =  0;
            "media.autoplay.enabled" =  true;
            "media.eme.enabled" =  false;
            "media.gmp-widevinecdm.enabled" =  false;
            "media.navigator.enabled" =  false;
            "media.peerconnection.enabled" =  false;
            "media.video_stats.enabled" =  false;
            "network.allow-experiments" =  false;
            "network.captive-portal-service.enabled" =  false;
            "network.cookie.cookieBehavior" =  1;
            "network.dns.disablePrefetch" =  true;
            "network.dns.disablePrefetchFromHTTPS" =  true;
            "network.http.speculative-parallel-limit" =  0;
            "network.predictor.enable-prefetch" =  false;
            "network.predictor.enabled" =  false;
            "network.prefetch-next" =  false;
            "network.trr.mode" =  5;
            "privacy.donottrackheader.enabled" =  true;
            "privacy.donottrackheader.value" =  1;
            "privacy.query_stripping" =  true;
            "privacy.trackingprotection.cryptomining.enabled" =  true;
            "privacy.trackingprotection.enabled" =  true;
            "privacy.trackingprotection.fingerprinting.enabled" =  true;
            "privacy.trackingprotection.pbmode.enabled" =  true;
            "privacy.usercontext.about_newtab_segregation.enabled" =  true;
            "security.ssl.disable_session_identifiers" =  true;
            "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" =  false;
            "signon.autofillForms" =  false;
            "toolkit.telemetry.archive.enabled" =  false;
            "toolkit.telemetry.bhrPing.enabled" =  false;
            "toolkit.telemetry.cachedClientID" =  "";
            "toolkit.telemetry.enabled" =  false;
            "toolkit.telemetry.firstShutdownPing.enabled" =  false;
            "toolkit.telemetry.hybridContent.enabled" =  false;
            "toolkit.telemetry.newProfilePing.enabled" =  false;
            "toolkit.telemetry.prompted" =  2;
            "toolkit.telemetry.rejected" =  true;
            "toolkit.telemetry.reportingpolicy.firstRun" =  false;
            "toolkit.telemetry.server" =  "";
            "toolkit.telemetry.shutdownPingSender.enabled" =  false;
            "toolkit.telemetry.unified" =  false;
            "toolkit.telemetry.unifiedIsOptIn" =  false;
            "toolkit.telemetry.updatePing.enabled" =  false;
            "webgl.disabled" =  true;
            "webgl.renderer-string-override" =  " ";
            "webgl.vendor-string-override" =  " ";
          };
        };
      };
    };

    home.stateVersion = "24.11";
}
