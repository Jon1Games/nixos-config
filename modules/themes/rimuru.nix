{ pkgs, host, username, ... }:
{

  environment.sessionVariables = {
    WALLPAPER_PATH = "/home/${username}/nixos-config/backgrounds/rimuru_dimmed.jpg";
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
  # --- BEGIN> Home manager <BEGIN ---

  home-manager.users.${username} = {
    programs.ghostty.settings = {
      theme = "gruvbox";
      background-opacity = 0.5;
      adjust-cursor-thickness = 1;

      selection-clear-on-copy = true;
      mouse-hide-while-typing = true;
    };

    programs.vscode.profiles.default.userSettings = {
        "workbench.colorTheme" = "Dracula";
        "workbench.iconTheme" = "vs-seti";
        "editor.fontFamily" = "'Maple Mono', 'JetBrainsMono Nerd Font', monospace";
        "editor.fontSize" = 12;
        "editor.lineHeight" = 1.5;
        "editor.letterSpacing" = 0.5;
        "editor.cursorBlinking" = "phase";
        "editor.minimap.enabled" = false;
        "workbench.sideBar.location" = "left";
        "workbench.activityBar.location" = "side";
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";

        "workbench.colorCustomizations" = {
          "sideBar.background" = "#1e1f29ee";
          "editor.background" = "#181922dd"; # Slightly darker/more transparent for the editor workspace
          "activityBar.background" = "#181922ee";
          "titleBar.activeBackground" = "#15161dee";
          "titleBar.inactiveBackground" = "#15161d99";
          "terminal.background" = "#181922dd";
          "panel.background" = "#181922dd";
          
          "focusBorder" = "#8be9fd88";
          "list.activeSelectionBackground" = "#44475a88";
          "pickerGroup.border" = "#8be9fd";
          "progressBar.background" = "#8be9fd";
          "badge.background" = "#8be9fd";
          "badge.foreground" = "#181922";
        };
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
      "match:class ^(code)$, opacity 0.90 override"
    ];

    xdg.configFile."xournalpp/settings.xml" = {
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <settings>
          <property name="pressureSensitivity" value="true"/>
          <property name="minimumPressure" value="0.05"/>
          <property name="pressureMultiplier" value="1"/>
          <property name="zoomGesturesEnabled" value="true"/>
          <property name="selectedToolbar" value="Portrait"/>
          <property name="lastSavePath" value=""/>
          <property name="lastOpenPath" value=""/>
          <property name="lastImagePath" value=""/>
          <property name="edgePanSpeed" value="20"/>
          <property name="edgePanMaxMult" value="5"/>
          <property name="zoomStep" value="10"/>
          <property name="zoomStepScroll" value="2"/>
          <property name="displayDpi" value="-1"/>
          <property name="mainWndWidth" value="800"/>
          <property name="mainWndHeight" value="600"/>
          <property name="maximized" value="true"/>
          <property name="showToolbar" value="true"/>
          <property name="showSidebar" value="true"/>
          <property name="sidebarWidth" value="151"/>
          <property name="sidebarNumberingStyle" value="1"/>
          <property name="sidebarOnRight" value="false"/>
          <property name="scrollbarOnLeft" value="false"/>
          <property name="menubarVisible" value="true"/>
          <property name="filepathShownInTitlebar" value="false"/>
          <property name="pageNumberShownInTitlebar" value="false"/>
          <property name="numColumns" value="1"/>
          <property name="numRows" value="1"/>
          <property name="viewFixedRows" value="false"/>
          <property name="showPairedPages" value="false"/>
          <property name="layoutVertical" value="false"/>
          <property name="layoutRightToLeft" value="false"/>
          <property name="layoutBottomToTop" value="false"/>
          <property name="numPairsOffset" value="1"/>
          <property name="emptyLastPageAppend" value="disabled"/>
          <property name="defaultPaperBgColor" value="0x2E3440"/>
          <property name="defaultPaperLightBgColor" value="0x2E3440"/>
          <property name="defaultPaperType" value="graph"/>
          <property name="defaultPaperRulerColor" value="0x4C566A"/>
          <property name="gridSize" value="14.17"/>
          <property name="pageTemplate" value="xoj/template&#10;copyLastPageSettings=false&#10;copyLastPageSize=false&#10;size=595.275591x841.889764&#10;backgroundType=graph&#10;backgroundColor=#2E3440&#10;"/>
        </settings>
      '';
      force = true;
    };
    xdg.configFile."xournalpp/toolbar.ini" = {
      text = ''
        [General]
        version=1
        [Toolbars]
        ColorPalette=COLOR(0xECEFF4),COLOR(0x88C0D0),COLOR(0x8FBCBB),COLOR(0xA3BE8C),COLOR(0xEBCB8B),COLOR(0xD08770),COLOR(0xBF616A),COLOR(0xB48EAD),COLOR(0xF5C2E7),COLOR(0x4C566A)
        [Toolbar.Main]
        0=TOOL(PEN),TOOL(ERASER),TOOL(HIGHLIGHTER),SEPARATOR,SIZE(1),SIZE(2),SIZE(3),SEPARATOR,COLOR_PALETTE,SEPARATOR,UNDO,REDO
      '';
      force = true;
    };
 }; # --- END> Home manager <END ---
}
