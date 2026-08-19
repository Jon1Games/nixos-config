{ pkgs, ... }:
{
  services.pcscd.enable = true; # Needed if using YubiKey PIV/GPG/CCID features

  security = {
    rtkit.enable = true;
    sudo.enable = true;

    pam.services = {
      swaylock.enableGnomeKeyring = true;
      hyprlock.enableGnomeKeyring = true;
    };
  };

  # Essential packages for managing keys
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
    libu2f-host
    pam_u2f
  ];
}
