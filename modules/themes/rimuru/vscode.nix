{ pkgs, host, username, lib, ... }:
{
  home-manager.users.${username}.programs.vscode.profiles.default.userSettings = {
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
  }

