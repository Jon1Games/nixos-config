{ ... }:
{
  imports = [
    ./cli.nix
    ./dev.nix
    ./gui.nix
    ./nix.nix
    ./management.nix
  ];

  services.easyeffects = {
    enable = true;
    preset = "Default";
  };
}
