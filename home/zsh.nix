{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      source ${../dotfiles/zshrc}
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
}
