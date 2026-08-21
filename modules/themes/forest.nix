{ pkgs, ... }:
{

  imporot = [
    #./../home/zsh/themes/p10k.nix 
  ];

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

  programs.ghostty.settings = {
    theme = "gruvbox";
    background-opacity = 0.5;
    adjust-cursor-thickness = 1;

    selection-clear-on-copy = true;
    mouse-hide-while-typing = true;
  };
}
