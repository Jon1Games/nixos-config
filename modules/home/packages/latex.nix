{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    texstudio
    texliveFull
  ];
}
