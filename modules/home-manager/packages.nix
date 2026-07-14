{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    nixd
    nixfmt
    tree
    wget
    colima
    docker
  ];
}
