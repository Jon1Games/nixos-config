{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    texstudio
    texliveFull
    fontconfig
  ];

  fonts.fontconfig.enable = true;

  # DEKLARATIVE TEXSTUDIO KONFIGURATION
  #home.file.".config/texstudio/texstudio.ini".text = ''
  #  [General]
  #  IniVersion=3
  #  Appearance\Style=Orion Dark
  #  Appearance\ColorScheme=Modern - dark

  #  [Editor]
  #  Editor\Line%20Number%20Mode=1
    
  #  [Advanced%20Editor]
  #'';
}
