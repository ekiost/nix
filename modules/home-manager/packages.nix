{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    colima
    docker
    fastfetch
    fzf
    nixd
    nixfmt-rfc-style
    speedtest-cli
    tldr
    tree
    wget
  ];
}
