{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
  };

  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "hyprland" "gtk" ];
	"org.freedesktop.impl.portal.Screencast" = "hyprland";
      };
      hyprland = {
        default = [ "gtk" "hyprland" ];
	"org.freedesktop.impl.portal.Screencast" = "hyprland";
      };
    };

    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
