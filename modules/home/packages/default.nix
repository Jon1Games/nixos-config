{ ... }:
{
  imports = [
    ./cli.nix
    ./dev.nix
    ./gui.nix
    ./nix.nix
    ./management.nix
    ./latex.nix
  ];

  services.easyeffects = {
    enable = true;
    preset = "Default";
  };
}
