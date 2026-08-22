{ pkgs, ... }:
{
  home.packages = with pkgs; [
    easyeffects
    pulsemixer
    #carla      # Keyboard auto software
    qpwgraph
  ];

  services.easyeffects = {
    enable = true;
    preset = "Default";
  };
}
