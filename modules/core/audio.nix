{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    easyeffects
    pulsemixer
    carla
    qpwgraph
    sfizz
    soundfont-fluid r3
    lsp-plugins
    calf
  ];

  environment.variables = {
    LV2_PATH = "/run/current-system/sw/lib/lv2";
    LADSPA_PATH = "/run/current-system/sw/lib/ladspa";
    DSSI_PATH = "/run/current-system/sw/lib/dssi";
    VST_PATH = "/run/current-system/sw/lib/vst";
    VST3_PATH = "/run/current-system/sw/lib/vst3";
  };

  services.easyeffects = {
    enable = true;
    preset = "Default";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # Stellt die JACK-Schnittstelle für Carla bereit
  };
}
