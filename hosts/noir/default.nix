{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core

    #./../../modules/themes/forest.nix
    ./../../modules/themes/rimuru.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";

  # Force the kernel to bypass standard power management assumptions
  # and explicitly command the motherboard via ACPI or PCI lanes.
  # this fixed an error for me where the OS shutdown but the hardware remained active
  boot.kernelParams = [ 
    "reboot=acpi" 
    "acpi=force" 
  ];
}
