{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uv
    gnumake
    python3
    dotnet-sdk_11
    nodejs
    # Open URLs in the Windows default browser (needed for browser sign-in flows)
    (writeShellScriptBin "xdg-open" ''
      exec /mnt/c/Windows/System32/rundll32.exe url.dll,FileProtocolHandler "$1"
    '')
  ];

  # uv-installed tools, e.g. azure-cli (nixpkgs' build is blocked by a broken fabric dependency)
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting # Disable greeting
      '';
      shellAliases = {
        config-update = "nix flake update --flake ~/.config/nix";
        config-switch = "sudo nixos-rebuild switch --flake ~/.config/nix#nixos";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };
  };
}
