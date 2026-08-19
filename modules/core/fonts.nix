{ pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true;

    packages = with pkgs; [
      maple-mono-custom

      noto-fonts
      public-sans

      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only

      # twemoji-color-font
      noto-fonts-color-emoji
    ];
  };
}
