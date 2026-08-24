{ pkgs, ... }:
{
  services = {
    ratbagd.enable = true;
    input-remapper.enable = true;
  };

  environment.systemPackages = with pkgs; [
    piper
    input-remapper
  ];
}
