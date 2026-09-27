{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    nordic
    papirus-icon-theme
    bibata-cursors
    glib
  ];

  imports = [
    ./spicetify.nix
    ./vscode.nix
    ./xournalpp.nix
    ./gtk.nix
  ];

  environment.sessionVariables = {
    WALLPAPER_PATH = "/home/${username}/nixos-config/backgrounds/rimuru_dimmed.jpg";
  };

  home-manager.users.${username}.home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    GTK_THEME = "Nordic";
  };

  home-manager.users.${username}.home.file.".p10k.zsh".source = ./.rimuru.zsh;

  home-manager.users.${username}.programs.ghostty.settings = {
    theme = "gruvbox";
    background-opacity = 0.5;
    adjust-cursor-thickness = 1;

    selection-clear-on-copy = true;
    mouse-hide-while-typing = true;
  };
}