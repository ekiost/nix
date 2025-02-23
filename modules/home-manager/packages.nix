{ pkgs, ... }:
{
  home.packages = with pkgs; [
    colima
    coreutils
    docker
    fastfetch
    fzf
    htop
    httpie
    nixd
    nixfmt-rfc-style
    nvtopPackages.apple
    speedtest-cli
    tldr
    tree
    wget
  ];
}
