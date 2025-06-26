{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    fastfetch
    fzf
    nixd
    nixfmt-rfc-style
    speedtest-cli
    tldr
    tree
    wget
    devenv
  ];
}
