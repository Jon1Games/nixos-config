{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [

  ];

  imports = [
    ./spicetify.nix
  ];

  environment.sessionVariables = {
    WALLPAPER_PATH = "/home/${username}/nixos-config/backgrounds/forest.jpg";
  };

  home-manager.users.${username} = {
    imports = [ ./gtk.nix ];

    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_STYLE_OVERRIDE = "kvantum";
      GTK_THEME = "Colloid-Green-Dark-Gruvbox";
    };

    home.file.".p10k.zsh".source = ./.forest.zsh;

    programs.ghostty.settings = {
      theme = "gruvbox";
      background-opacity = 0.5;
      adjust-cursor-thickness = 1;

      selection-clear-on-copy = true;
      mouse-hide-while-typing = true;
    };
  };
}