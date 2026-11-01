{ pkgs, lib, ... }:
let
  mod = "SUPER";
  lua = lib.generators.mkLuaInline;

  bindWith = opts: key: action: { _args = [ key (lua action) (lua opts) ]; };
  bind = key: action: { _args = [ key (lua action) ]; };
  locked        = bindWith "{ locked = true }";
  lockedRepeat  = bindWith "{ locked = true, repeating = true }";
  repeating     = bindWith "{ repeating = true }";
  onRelease     = bindWith "{ release = true }";

  exec = cmd: ''hl.dsp.exec_cmd([[${cmd}]])'';
in {
  home.packages = with pkgs; [ swayosd ];

  wayland.windowManager.hyprland.settings.bind = [
    # mute / mic
    (bind "XF86AudioMute" (exec "swayosd-client --output-volume mute-toggle"))
    (bind "XF86AudioMicMute" (exec "toggle-mic"))

    # brightness: jump to max / min
    (locked "${mod} + XF86MonBrightnessUp" (exec "swayosd-client --brightness 100"))
    (locked "${mod} + XF86MonBrightnessDown" (exec "swayosd-client --brightness 0"))

    # brightness: step (locked + repeating, like bindel)
    (lockedRepeat "XF86MonBrightnessUp" (exec "swayosd-client --brightness raise"))
    (lockedRepeat "XF86MonBrightnessDown" (exec "swayosd-client --brightness lower"))

    # volume (repeating, like binde)
    (repeating "XF86AudioRaiseVolume" (exec "swayosd-client --output-volume +2"))
    (repeating "XF86AudioLowerVolume" (exec "swayosd-client --output-volume -2"))
    (repeating "${mod} + F11" (exec "swayosd-client --output-volume +2"))
    (repeating "${mod} + F12" (exec "swayosd-client --output-volume -2"))

    # lock keys (on release, like bindr)
    (onRelease "CAPS + Caps_Lock" (exec "swayosd-client --caps-lock"))
    (onRelease "Scroll_Lock" (exec "swayosd-client --scroll-lock"))
    (onRelease "Num_Lock" (exec "swayosd-client --num-lock"))
  ];

  services.swayosd.enable = true;

  xdg.configFile."swayosd/config.toml".text = ''
    [server]
    max_volume = 100
    show_percentage = true
  '';

  xdg.configFile."swayosd/style.css".text = ''
    window {
        padding: 0px 10px;
        border-radius: 25px;
        border: 10px;
        background: alpha(#282828, 0.99);
    }

    #container {
        margin: 15px;
    }

    image, label {
        color: #FBF1C7;
    }

    progressbar:disabled,
    image:disabled {
        opacity: 0.95;
    }

    progressbar {
        min-height: 6px;
        border-radius: 999px;
        background: transparent;
        border: none;
    }
    trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: alpha(#DDDDDD, 0.2);
    }
    progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: #FBF1C7;
    }
  '';
}
