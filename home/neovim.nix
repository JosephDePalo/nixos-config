{ pkgs, ... }:

{
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

  xdg.configFile."nvim/init.lua".source = ../dotfiles/nvim/init.lua;
  xdg.configFile."nvim/lua".source = ../dotfiles/nvim/lua;
}
