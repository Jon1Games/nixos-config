{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings.monitor = [
      {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = "auto";
      }
    ];
    
    extraConfig = ''
      require("monitors")
      require("workspaces")
    '';
  };

  home.packages = with pkgs; [ nwg-displays ];
}
