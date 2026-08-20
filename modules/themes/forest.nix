{ pkgs, ... }:
{

  environment.sessionVariables = {
    WALLPAPER_PATH = "/home/jon1games/nixos-config/backgrounds/forest.jpg";
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Maple Mono"
      "JetBrainsMono Nerd Font"
    ];
    sansSerif = [ "Public Sans" ];
    serif = [ "Noto Serif" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
