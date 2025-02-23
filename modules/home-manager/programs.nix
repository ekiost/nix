{ ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        config-switch = "darwin-rebuild switch --flake ~/.config/nix";
        config-update = "nix flake update --flake ~/.config/nix";
      };
    };

    oh-my-posh = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ./oh-my-posh.json);
    };

    git = {
      enable = true;
      userName = "ekiost";
      userEmail = "choonkeatling@icloud.com";
      ignores = [
        ".DS_Store"
        ".vscode"
        ".idea"
        ".env*"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    git-credential-oauth.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
