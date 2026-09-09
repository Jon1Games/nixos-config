{ pkgs, username, ... }:

let
  # Fetch and build linux-id from source since it's typically an AUR/external package
  linux-id = pkgs.buildGoModule rec {
    pname = "linux-id";
    version = "0.2.3";

    src = pkgs.fetchFromGitHub {
      owner = "matejsmycka";
      repo = "linux-id";
      rev = "v${version}";
      sha256 = "sha256-0lO4lIga/tYzXDOGxYREr2Bgu1P6/3GH67ijivl42D8="; # Replace with actual hash after first build attempt
    };

    vendorHash = "sha256-vmWYSlCP09cVgQa7owAZeDzGfEdMHOqQlqDuzTkRjdI="; # Replace with actual vendor hash if dependencies require it
  };
in
{
  services.pcscd.enable = true;

  security = {
    rtkit.enable = true;
    sudo.enable = true;

    pam.services = {
      swaylock.enableGnomeKeyring = true;
      hyprlock.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };

  # Required kernel module and udev permissions for virtual USB HID emulation
  boot.kernelModules = [ "uhid" "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uhid", SUBSYSTEM=="misc", GROUP="input", MODE="0660"
  '';

  # Ensure your user has access to both TPM (tss) and input (uhid) groups
  users.users.${username}.extraGroups = [ "tss" "input" "wheel" "audio" "video"];

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
    libu2f-host
    pam_u2f
    tpm2-tools
    pinentry-qt
    linux-id
  ];

  # Replace the old tpm-fido systemd user service with linux-id
  systemd.user.services.linux-id = {
    description = "Linux-ID CTAP2/FIDO2 TPM Passkey Daemon";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Environment = "PATH=${pkgs.pinentry-qt}/bin:${pkgs.lib.makeBinPath [ linux-id pkgs.tpm2-tools ]}";
      ExecStart = "${linux-id}/bin/linux-id";
      Restart = "always";
    };
  };

  services.dbus.packages = [ pkgs.gcr ];
}
