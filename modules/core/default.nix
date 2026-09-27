{ ... }:
{
  imports = [
    ./nixpkgs.nix
    ./bootloader.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./bluetooth.nix
    ./fonts.nix
    ./nh.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./flatpak.nix
    ./user.nix
    ./wayland.nix
    #./virtualization.nix	# KVM / Docker
    #./qmk.nix			# VIA, VIAl, udev-rules
    ./piper.nix			# Gamingmouse
    ./audio.nix
    ./printer.nix
  ];
}
