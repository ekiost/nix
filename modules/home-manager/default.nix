{ pkgs, pwnvim, ... }: {
  # This is internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    fastfetch
    nixpkgs-fmt
    speedtest-rs
  ];

  # VSCode settings
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
      github.copilot
      github.copilot-chat
    ];
    userSettings =
      {
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
        "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";
        "git.autofetch" = true;
      };
  };

  # Zsh settings
  programs.zsh = {
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
  programs.git = {
    enable = true;
    userName = "ekiost";
    userEmail = "choonkeatling@icloud.com";
    ignores = [ ".DS_Store" ".vscode" ".idea" ];
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  home.file.".p10k.zsh".source = ./p10k-config/p10k.zsh;
}
