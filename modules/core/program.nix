{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    zsh.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

    appimage.enable = true;

    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [ ];
  };
}
