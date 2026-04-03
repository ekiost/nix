{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    fzf
    nixd
    nil
    nixfmt
    speedtest-cli
    tldr
    tree
    wget
    colima
    docker
  ];
}
