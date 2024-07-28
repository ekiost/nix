{ pkgs, pwnvim, ... }: {
  # This is internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    fastfetch
    nixpkgs-fmt
    speedtest-rs
  ];

  programs = {
    # Zsh settings
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
        "git"
        "docker"
      ];
      initExtra = "source ~/.p10k.zsh";
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      shellAliases = {
        config-switch = "darwin-rebuild switch --flake ~/.config/nix";
      };
    };

    # Git settingsgit config --list
    git = {
      enable = true;
      userName = "ekiost";
      userEmail = "choonkeatling@icloud.com";
      ignores = [ ".DS_Store" ".vscode" ".idea" ];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    gh = {
      enable = true;
      extensions = [
        pkgs.gh-dash
      ];
    };
  };

  home.file.".p10k.zsh".source = ./p10k-config/p10k.zsh;
}
