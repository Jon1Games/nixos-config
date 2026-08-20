{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core

    ./../../modules/themes/forest.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
