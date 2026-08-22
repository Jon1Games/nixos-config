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

    pki.certificates = [
      # GamingLounge.ME internal CA
      ''
-----BEGIN CERTIFICATE-----
MIICsDCCAlegAwIBAgIUU2uqErtBdMCw2rhRHBQKkcTOvEIwCgYIKoZIzj0EAwMw
ga0xCzAJBgNVBAYTAkRFMQwwCgYDVQQIDANOUlcxDzANBgNVBAcMBldpdHRlbjEV
MBMGA1UECgwMR2FtaW5nTG91bmdlMQswCQYDVQQLDAJJVDE2MDQGA1UEAwwtR2Ft
aW5nTG91bmdlIExvY2FsIFJvb3QgQ0EgaXQuZ2FtaW5nbG91bmdlLm1lMSMwIQYJ
KoZIhvcNAQkBFhRpbmZvQGdhbWluZ2xvdW5nZS5tZTAeFw0yNjA1MDcwNzQ0Mjda
Fw0zNjA1MDQwNzQ0MjdaMIGtMQswCQYDVQQGEwJERTEMMAoGA1UECAwDTlJXMQ8w
DQYDVQQHDAZXaXR0ZW4xFTATBgNVBAoMDEdhbWluZ0xvdW5nZTELMAkGA1UECwwC
SVQxNjA0BgNVBAMMLUdhbWluZ0xvdW5nZSBMb2NhbCBSb290IENBIGl0LmdhbWlu
Z2xvdW5nZS5tZTEjMCEGCSqGSIb3DQEJARYUaW5mb0BnYW1pbmdsb3VuZ2UubWUw
WTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAAR0OfkuifwbXWGiho3up4WtwYz/K3OE
NoHg+32zN1qhiyWjKPH/O+5gWvo3ez0T3DXqQmUc4ffYlWxo49nR5Mjmo1MwUTAd
BgNVHQ4EFgQU4iUzE7Fg6QXd+LM7RCBesU7BSjIwHwYDVR0jBBgwFoAU4iUzE7Fg
6QXd+LM7RCBesU7BSjIwDwYDVR0TAQH/BAUwAwEB/zAKBggqhkjOPQQDAwNHADBE
AiBe1Q7/fPUq7d6hxQeLp/61vRAfXhfdC54mlT3tSinCdgIgXRzMTMeKD//kih5A
4TFAxI4kp6KVXcMwVZpUx8sg57M=
-----END CERTIFICATE-----
      ''
    ];
  };

  # Essential packages for managing keys
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
    libu2f-host
    pam_u2f
  ];
}
