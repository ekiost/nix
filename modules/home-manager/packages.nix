{ pkgs, ... }:
{
  home.packages = with pkgs; [
    colima
    coreutils
    docker
    fastfetch
    fzf
    htop
    nixd
    nixfmt-rfc-style
    nvtopPackages.apple
    speedtest-cli
    tldr
    tree
    wget
  ];
}
