{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum

    texstudio
    texliveFull
  ];
}
