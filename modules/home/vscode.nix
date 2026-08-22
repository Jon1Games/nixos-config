{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode; 

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      dracula-theme.theme-dracula
      jnoortheen.nix-ide
    ];

    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none"; # Updates werden sauber über NixOS verwaltet
    };
  };
}

