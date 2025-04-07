{ pkgs, inputs, config, ... }:
{
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      keepassxc # Password Vault
      spotify # Music
      obsidian # Notes
      bat # Better cat
      eza # Better ls
      procs # Better ps
      ripgrep # Better grep
      flameshot # Screenshot Utility
      pywalfox-native # Firefox Theme
      dconf # For GTK theme
      fzf # Fuzzy Finder
      zoxide # Better cd
      nil # Nix Language Server
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        set -o vi
        eval "$(zoxide init zsh)"
        function calc { python -c "print($1)" }
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
        confs = "srch $CFGDIR";
        build = "sudo nixos-rebuild switch --flake $CFGDIR#$HOST";
        try = "nix-shell -p";
        wttr = "curl https://wttr.in";
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

    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };

    services.redshift = {
      enable = true;
      latitude = "40.7128";
      longitude = "74.0060";
      provider = "manual";
      dawnTime = "6:00-7:45";
      duskTime = "18:45-20:30";
      enableVerboseLogging = true;
    };



    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-surround
        syntastic
        auto-pairs
        tabular
        vim-markdown
        polyglot
        nvim-lspconfig 
        telescope-nvim
        vim-sleuth
        which-key-nvim
        image-nvim
        pywal-nvim
        lualine-nvim
        plenary-nvim
        obsidian-nvim
      ];
      coc.enable = true;
      extraConfig = ''
        colorscheme pywal
        set conceallevel=2
        set relativenumber number spell
        let mapleader = " "
        function! ToggleLineNumbers()
          if &number
            set nonumber
          else
            set number
          endif
        endfunction

        function! ToggleRelLineNumbers()
          if &relativenumber
            set norelativenumber
          else
            set relativenumber
          endif
        endfunction

        nnoremap <Space> <Nop>
        nnoremap <F10> :call ToggleLineNumbers()<CR>
        nnoremap <F11> :call ToggleRelLineNumbers()<CR>
        nnoremap <leader>f :Telescope find_files cwd=%:p:h<CR>
        nnoremap <leader>F :Telescope find_files cwd=

      '';
      extraLuaConfig = ''
        lspconfig = require('lspconfig')
        lspconfig.nil_ls.setup{}

        local project_dir = vim.fn.getcwd()
        package.path = package.path .. ";" .. project_dir .. "/?.lua"
        local is_nix_shell = os.getenv("IN_NIX_SHELL") == "1"
        if is_nix_shell then
          pcall(require, "nvim_config")
        end
        require("image").setup({
          backend = "kitty",
          processor = "magick_rock", -- or "magick_cli"
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              floating_windows = false, -- if true, images will be rendered in floating markdown windows
              filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
              enabled = true,
              filetypes = { "norg" },
            },
            typst = {
              enabled = true,
              filetypes = { "typst" },
            },
            html = {
              enabled = false,
            },
            css = {
              enabled = false,
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,
          max_height_window_percentage = 50,
          window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
          editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
        })
        local lualine = require('lualine')

        lualine.setup {
          options = {
            theme = 'pywal-nvim',
          },
        }

        require("obsidian").setup({
          workspaces = {
            {
              name = "cybervault",
              path = "/mnt/Documents/Notes/cybervault",
            },
            {
              name = "cyber",
              path = "/mnt/Documents/Notes/cyber",
            },
          }
        })
      '';
      extraLuaPackages = ps: [ ps.magick ];
      extraPackages = [ pkgs.imagemagick ];
    };

    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono";
      font.size = 12;
      extraConfig = ''
        include ~/.cache/wal/colors-kitty.conf
        background_opacity 0.95
        editor nvim
        kitty_mod alt
        enabled_layouts splits, stack, grid
        layout splits
      '';
      settings = {
        enable_audio_bell = false;
        window_margin_width = 1;
        window_padding_width = 6;
        dynamic_background_opacity = true;
        allow_remote_control = true;
        listen_on = "unix:/tmp/mykitty";
        scrollback_pager = ''
          nvimpager
        '';
      };
      keybindings = {
        "f1" = "launch --type=tab --cwd=current";
        "kitty_mod+ctrl+j" = "launch --location=hsplit --cwd=current";
        "kitty_mod+ctrl+l" = "launch --location=vsplit --cwd=current";
        "kitty_mod+shift+h" = "resize_window wider";
        "kitty_mod+shift+l" = "resize_window narrower";
        "kitty_mod+shift+j" = "resize_window shorter";
        "kitty_mod+shift+k" = "resize_window taller";
        "kitty_mod+h" = "neighboring_window left";
        "kitty_mod+l" = "neighboring_window right";
        "kitty_mod+j" = "neighboring_window down";
        "kitty_mod+k" = "neighboring_window up";
        "kitty_mod+o" = "set_background_opacity +0.05";
        "kitty_mod+shift+o" = "set_background_opacity -0.05";
        "kitty_mod+s" = "show_scrollback";
        "kitty_mod+g" = "kitten kitty_grab/grab.py";
      };
    };

    programs.starship.enable = true;
    programs.zathura = {
      enable = true;
      extraConfig = "include ${config.home.homeDirectory}/.cache/wal/zathurarc";
    };
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

    xdg.configFile = {
      "qtile/config.py".source = inputs.self + "/configs/qtile/config.py";
      "wal/templates".source = inputs.self + "/configs/wal/templates";
      "kitty/open-actions.conf".source = inputs.self + "/configs/kitty/open-actions.conf";
      "kitty/kitty_grab".source = inputs.kitty-grab;
    };

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
      userSettings = {
        "keyboard.dispatch" = "keyCode";
        "vim.useCtrlKeys" = false;
        "workbench.colorTheme" = "Wal";
      };
    };
    gtk = {
      enable = true;
      theme.package = pkgs.theme-obsidian2;
      theme.name = "Obsidian-2";
    };

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
            "media.autoplay.default" =  0;
            "media.autoplay.enabled" =  true;
            "media.eme.enabled" =  false;
            "media.gmp-widevinecdm.enabled" =  false;
            "media.navigator.enabled" =  false;
            "media.peerconnection.enabled" =  false;
            "media.video_stats.enabled" =  false;
            "network.allow-experiments" =  false;
            "network.captive-portal-service.enabled" =  false;
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
