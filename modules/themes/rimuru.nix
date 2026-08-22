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

    programs.spicetify = {
      theme = {
        name = "comfy-rimuru";
        src = pkgs.fetchFromGitHub {
          owner = "Comfy-Themes";
          repo = "Spicetify";
          rev = "b3f8a24e444521887c21be5c69fc05a498a47664";
          hash = "sha256-sqvmSXJMLE2in/cB8ZIJE/t4J5D0PKRddWECdYJjgX0=";
        };
      };
      customColorScheme = {
        text               = "e5e9f0"; 
        subtext            = "64727d"; 
        main               = "1e1e24";
        sidebar            = "1e1e24"; 
        player             = "1e1e24"; 
        card               = "4c566a"; 
        shadow             = "000000"; # Blank out canvas dropshadow overlays
        selected-row       = "4c566a";
        button             = "56b6c2"; 
        button-active      = "61afef"; 
        button-disabled    = "535965";
        sidebar-active     = "61afef"; 
        notification       = "c678dd"; 
        notification-error = "e06c75"; 
        misc               = "e5c07b"; 
      };
    };
    wayland.windowManager.hyprland.settings.windowrule = [
      {
        name = "spotify-transparency";
        "match:class" = "^(Spotify)$";
        opacity = "0.825 0.825";
      }
    ];
  };
}
