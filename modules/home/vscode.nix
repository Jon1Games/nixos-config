{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode; 

    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      jnoortheen.nix-ide
    ];

    profiles.default.userSettings = {
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none";
    };
  };
}

