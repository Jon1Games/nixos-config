{ ... }:
{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./../../modules/periphery/g502hero.nix

    # Software
    ./../../modules/core
    
    # Theme
    #./../../modules/themes/forest
    ./../../modules/themes/rimuru
  ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  # Some motherboards/firmware implementations ignore a normal ACPI poweroff and
  # leave the board powered on even after the OS has halted. This forces the
  # kernel to initialize ACPI more aggressively and lets the firmware perform the
  # final poweroff sequence correctly.
  #
  # This needs a full rebuild + reboot to take effect.
  boot = {
    kernelParams = [
      "acpi=force"
      "reboot=acpi"
      "apm=power_off"
    ];
  };
}
