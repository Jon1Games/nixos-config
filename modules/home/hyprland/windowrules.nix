{ lib, ... }:
let
  cls = c: { class = "^(${c})$"; };
  title = t: { title = "^(${t})$"; };

  rule = name: match: effects: { inherit name match; } // effects;

  floatClasses = [
    "imv"
    "mpv"
    "zenity"
    "waypaper"
    ".sameboy-wrapped"
    "org.gnome.Calculator"
    "org.gnome.FileRoller"
    "org.pulseaudio.pavucontrol"
  ];

  portalEffects = {
    dim_around = true;
    float = true;
    size = "550 600";
    center = true;
  };
in
{
  wayland.windowManager.hyprland.settings = {
    window_rule =
      # float
      (map (c: rule "float-${c}" (cls c) { float = true; }) floatClasses)
      ++ [
        (rule "pin-rofi" (cls "rofi") { pin = true; })
        (rule "pin-waypaper" (cls "waypaper") { pin = true; })
        (rule "tile-aseprite" (cls "Aseprite") { tile = true; })

        (rule "size-zenity" (cls "zenity") { size = "850 500"; })

        (rule "volume-control" (title "Volume Control") {
          size = "700 450";
          move = "40 55%";
        })

        (rule "pip" (title "Picture-in-Picture") {
          pin = true;
          float = true;
        })

        # idle inhibit
        (rule "idle-mpv" (cls "mpv") { idle_inhibit = "focus"; })
        (rule "idle-youtube" {
          class = "^(zen-beta)$";
          title = "^(.*YouTube.*)$";
        } { idle_inhibit = "focus"; })
        (rule "idle-zen" (cls "zen") { idle_inhibit = "fullscreen"; })

        # portals / screen share picker
        (rule "portal-gtk" (cls "xdg-desktop-portal-gtk") portalEffects)
        (rule "share-picker" (title "Select a window to share") portalEffects)

        (rule "xwayland-rounding" { xwayland = true; } { rounding = 0; })

        # no gaps / borders when only one window
        (rule "smart-gaps-w" {
          float = false;
          workspace = "w[tv1]";
        } {
          border_size = 0;
          rounding = 0;
        })
        (rule "smart-gaps-f" {
          float = false;
          workspace = "f[1]";
        } {
          border_size = 0;
          rounding = 0;
        })
      ];

    layer_rule = [
      {
        name = "dim-rofi";
        match.namespace = "rofi";
        dim_around = true;
      }
      {
        name = "dim-swaync";
        match.namespace = "swaync-control-center";
        dim_around = true;
      }
    ];

    workspace_rule = [
      { workspace = "w[tv1]"; gaps_out = 0; gaps_in = 0; }
      { workspace = "f[1]"; gaps_out = 0; gaps_in = 0; }
    ];
  };
}
