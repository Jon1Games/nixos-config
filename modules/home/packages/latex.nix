{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    texstudio
    texliveFull
  ];

  home.file.".config/texstudio/texstudio.ini".text = ''
    [General]
    IniVersion=12
    Language=de
    
    [User]
    Build\Default%20Compiler=txs:///pdflatex
    Tools\Viewer=txs:///view-pdf-internal --embedded

    [Editor]
    Font%20Family=Monospace
    Font%20Size=12
    Line%20Numbers=1
    Word%20Wrap=true

    [Preview]
    Tool=InlinePreview

    # --- FARBSCHEMA ABSTIMMUNG (Kühles Dark Theme) ---
    [Formats]
    # Hintergrund des Editors: Tiefes, mattes Indigo-Grau
    Special%20Format\Background=#2e3440
    # Normaler Text: Silberweiß / Hellgrau
    Normal\Foreground=#d8dee9
    # LaTeX-Befehle (\begin, \section): Rimuru-Cyan / Magisches Blau
    Keyword\Foreground=#88c0d0
    Keyword\Bold=true
    # Kommentare: Gedämpftes Grau-Blau
    Comment\Foreground=#4c566a
    Comment\Italic=true
    # Mathematische Formeln ($...$): Sanftes Eisblau
    Math\Foreground=#8fbcbb
    # Strings / Text in Klammern: Beruhigendes Salbei/Hellblau
    String\Foreground=#a3be8c
    # Zeilennummerierung Spalte
    LineNumber\Background=#232831
    LineNumber\Foreground=#4c566a
  '';
}
