{ pkgs, host, ... }:
{

  environment.sessionVariables = {
    WALLPAPER_PATH = "/home/jon1games/nixos-config/backgrounds/rimuru_dimmed.jpg";
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

  home-manager.users.jon1games = {
    programs.ghostty.settings = {
      theme = "gruvbox";
      background-opacity = 0.5;
      adjust-cursor-thickness = 1;

      selection-clear-on-copy = true;
      mouse-hide-while-typing = true;
    };

    home.file.".p10k.zsh".source = ./.rimuru.zsh;
  };
}
