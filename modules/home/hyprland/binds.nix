{ lib, ... }:
let
  mod = "SUPER";
  lua = lib.generators.mkLuaInline;

  # key + action (+ optional bind flags)
  bind = key: action: { _args = [ key (lua action) ]; };
  bindWith = opts: key: action: { _args = [ key (lua action) (lua opts) ]; };
  locked = bindWith "{ locked = true }";
  repeating = bindWith "{ repeating = true }";

  # [[ ]] long strings so quotes inside commands don't need escaping
  exec = cmd: ''hl.dsp.exec_cmd([[${cmd}]])'';

  focusWs = ws: ''hl.dsp.focus({ workspace = "${ws}" })'';
  focusDir = d: ''hl.dsp.focus({ direction = "${d}" })'';
  moveWs = ws: ''hl.dsp.window.move({ workspace = "${ws}" })'';
  moveWsSilent = ws: ''hl.dsp.window.move({ workspace = "${ws}", follow = false })'';
  moveDir = d: ''hl.dsp.window.move({ direction = "${d}" })'';
  fs = m: ''hl.dsp.window.fullscreen({ mode = "${m}" })'';

  # hyprctl fallback for dispatchers I don't know the Lua name of
  hctl = args: exec "hyprctl dispatch ${args}";

  dirs = [
    { k = "left";  v = "h"; d = "l"; vec = "-80 0"; }
    { k = "right"; v = "l"; d = "r"; vec = "80 0"; }
    { k = "up";    v = "k"; d = "u"; vec = "0 -80"; }
    { k = "down";  v = "j"; d = "d"; vec = "0 80"; }
  ];
  dirName = { l = "left"; r = "right"; u = "up"; d = "down"; };

  # workspaces 1..10 (key 0 = workspace 10)
  workspaces = lib.genList (i: {
    key = if i == 9 then "0" else toString (i + 1);
    ws = toString (i + 1);
  }) 10;
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      binds = {
        scroll_event_delay = 100;
        movefocus_cycles_fullscreen = true;
      };
    };

    bind =
      [
        # apps
        (bind "${mod} + F1" (exec "show-keybinds"))
        (bind "${mod} + Return" (exec "ghostty --gtk-single-instance=true"))
        (bind "ALT + Return" (hctl "exec '[float; size 1111 700] ghostty'"))
        (bind "${mod} + SHIFT + Return" (hctl "exec '[fullscreen] ghostty'"))
        (bind "${mod} + B" (hctl "exec '[workspace 1 silent] zen-beta'"))
        (bind "${mod} + D" (exec "toggle-rofi rofi -show drun"))
        (bind "${mod} + SHIFT + D" (exec "vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland"))
        (bind "${mod} + E" (exec "nemo"))
        (bind "ALT + E" (hctl "exec '[float; size 1111 700] nemo'"))
        (bind "${mod} + SHIFT + B" (exec "toggle-waybar"))
        (bind "${mod} + C" (exec "hyprpicker -a"))
        (bind "${mod} + W" (exec "wallpaper-picker"))
        (bind "${mod} + SHIFT + W" (hctl "exec '[float; size 925 615] waypaper'"))
        (bind "${mod} + N" (exec "swaync-client -t -sw"))
        (bind "CTRL + SHIFT + Escape" (hctl "exec '[workspace 9] missioncenter'"))
        (bind "${mod} + equal" (exec "woomer"))
        (bind "${mod} + P" (exec "power-profile-menu"))
        (bind "${mod} + T" (exec "toggle-oppacity"))
        (bind "${mod} + XF86Display" (exec "toggle-display"))
        (bind "${mod} + CTRL + O" (exec "ocr"))

        # session
        (bind "${mod} + Escape" (exec "hyprlock"))
        (bind "ALT + Escape" (exec "hyprlock & systemctl suspend"))
        (bind "${mod} + SHIFT + Escape" (exec "power-menu"))

        # window state
        (bind "${mod} + Q" "hl.dsp.window.close()")
        (bind "${mod} + F" (fs "fullscreen"))
        (bind "${mod} + SHIFT + F" (fs "maximized"))
        (bind "${mod} + Space" (exec "toggle-float"))

        # focus floating / tiled
        (bind "CTRL + ALT + up" (hctl "focuswindow floating"))
        (bind "CTRL + ALT + down" (hctl "focuswindow tiled"))

        # empty workspace
        (bind "${mod} + CTRL + C" (moveWs "empty"))

        # scroll through workspaces
        (bind "${mod} + mouse_down" (focusWs "e-1"))
        (bind "${mod} + mouse_up" (focusWs "e+1"))

        # screenshots
        (bind "Print" (exec "screenshot --copy"))
        (bind "${mod} + Print" (exec "screenshot --save"))
        (bind "${mod} + SHIFT + Print" (exec "screenshot --swappy"))

        # clipboard
        (bind "${mod} + V" (exec ''toggle-rofi "cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"''))

        # fx keys
        (bind "code:196" (exec "/home/jon1games/nixos-config/scripts/scripts/hypixel-zombies-2guns.sh"))
        (bind "code:195" (exec "/home/jon1games/nixos-config/scripts/scripts/hypixel-zombies-3guns.sh"))

        # mouse
        (bind "${mod} + mouse:272" "hl.dsp.window.drag()")
        (bind "${mod} + mouse:273" "hl.dsp.window.resize()")
      ]

      # media
      ++ [
        (bind "XF86AudioPlay" (exec "playerctl play-pause"))
        (bind "XF86AudioNext" (exec "playerctl next"))
        (bind "XF86AudioPrev" (exec "playerctl previous"))
        (bind "XF86AudioStop" (exec "playerctl stop"))
      ]

      # focus (arrows + vim keys), then raise
      ++ lib.concatMap (x: lib.concatMap (key: [
        (bind "${mod} + ${key}" (focusDir (dirName.${x.d})))
        (bind "${mod} + ${key}" (hctl "alterzorder top"))
      ]) [ x.k x.v ]) dirs

      # move window in direction
      ++ lib.concatMap (x: map (key:
        bind "${mod} + SHIFT + ${key}" (moveDir (dirName.${x.d}))
      ) [ x.k x.v ]) dirs

      # nudge window
      ++ lib.concatMap (x: map (key:
        bind "${mod} + ALT + ${key}" (hctl "moveactive ${x.vec}")
      ) [ x.k x.v ]) dirs

      # resize (repeating)
      ++ lib.concatMap (x: map (key:
        repeating "${mod} + CTRL + ${key}" (hctl "resizeactive ${x.vec}")
      ) [ x.k x.v ]) dirs

      # workspaces
      ++ lib.concatMap (w: [
        (bind "${mod} + ${w.key}" (focusWs w.ws))
        (bind "${mod} + SHIFT + ${w.key}" (moveWsSilent w.ws))
      ]) workspaces

      # lid switch
      ++ [
        (locked "switch:on:Lid Switch" (exec "pidof hyprlock || hyprlock"))
      ];
  };
}
