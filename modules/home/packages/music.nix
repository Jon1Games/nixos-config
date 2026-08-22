{ pkgs, ... }:
{
  home.packages = with pkgs; [
    easyeffects
    pulsemixer
    carla
    qpwgraph
  ];

  services.easyeffects = {
    enable = true;
    preset = "Default";
  };
}
