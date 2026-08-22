{ pkgs, host, ... }:
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

  home-manager.users.jon1games = {
    programs.ghostty.settings = {
      theme = "gruvbox";
      background-opacity = 0.5;
      adjust-cursor-thickness = 1;

      selection-clear-on-copy = true;
      mouse-hide-while-typing = true;
    };

    home.file.".p10k.zsh".source = ./.forest.zsh;

    programs.spicetify = {
      theme = {
        name = "comfy-forest";
        src = pkgs.fetchFromGitHub {
          owner = "Comfy-Themes";
          repo = "Spicetify";
          rev = "b3f8a24e444521887c21be5c69fc05a498a47664";
          hash = "sha256-sqvmSXJMLE2in/cB8ZIJE/t4J5D0PKRddWECdYJjgX0=";
        };
      };
      customColorScheme = {
        text               = "e2e8f0"; # Mist white (clean and highly readable)
        subtext            = "708271"; # Sage/pine needles green (for muted text details)
        main               = "111812"; # Deep abyss forest green (near-black foundation)
        sidebar            = "0f1410"; # Slightly darker forest shadow for depth
        player             = "0d120e"; # Bottom playback bar shadow
        card               = "253327"; # Mossy bark green (for hovered elements/cards)
        shadow             = "000000"; # Pitch black depth accents
        selected-row       = "2f4032"; # Active highlight green
        button             = "529b67"; # Fresh forest foliage green (vibrant play button)
        button-active      = "70be86"; # Luminous leaf green (active click states)
        button-disabled    = "3a483d"; # Faded, dry leaf green
        sidebar-active     = "529b67"; # Active sidebar highlight green
        notification       = "cb9956"; # Soft autumn amber (for regular system alerts)
        notification-error = "b65252"; # Deep rust red (for layout error popups)
        misc               = "dfb15b"; # Golden sunbeam gold (for tracking meters and highlights)
      };
    };
  };
}
