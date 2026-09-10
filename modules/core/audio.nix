{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pipewire
    pipewire.jack
    easyeffects
    pulsemixer
    carla
    qpwgraph
    sfizz
    soundfont-fluid
    lsp-plugins
    calf
    surge-xt
    helm
    zynaddsubfx
    vital

    (makeDesktopItem {
      name = "carla-pw-jack";
      desktopName = "Carla (PipeWire-JACK)";
      genericName = "Audio Plugin Host";
      comment = "Launch Carla routed through PipeWire-JACK emulation";
      exec = "${pkgs.pipewire}/bin/pw-jack ${pkgs.carla}/bin/carla";
      icon = "carla";
      categories = [ "AudioVideo" "Audio" ];
      terminal = false;
    })
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
