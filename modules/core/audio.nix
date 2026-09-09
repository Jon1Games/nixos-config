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
    surge-XT
    helm
    zynaddsubfx
  ];

  environment.pathsToLink = [ "/share/soundfonts" ];
  environment.variables = {
    LV2_PATH = "/run/current-system/sw/lib/lv2";
    LADSPA_PATH = "/run/current-system/sw/lib/ladspa";
    DSSI_PATH = "/run/current-system/sw/lib/dssi";
    VST_PATH = "/run/current-system/sw/lib/vst";
    VST3_PATH = "/run/current-system/sw/lib/vst3";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
