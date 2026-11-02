{ lib, pkgs, host, ... }:
let
  lua = lib.generators.mkLuaInline;

  onStart = cmds: {
    _args = [
      "hyprland.start"
      (lua ''
        function()
        ${lib.concatMapStringsSep "\n" (c: "  hl.exec_cmd([[${c}]])") cmds}
        end
      '')
    ];
  };
in
{
  wayland.windowManager.hyprland.settings.on = [
    (onStart [
      # "hash dbus-update-activation-environment 2>/dev/null"
      "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

      "hyprlock"

      "nm-applet &"
      "poweralertd &"
      "wl-clip-persist --clipboard both &"
      "wl-paste --watch cliphist store &"
      "waybar &"
      "swaync &"
      "udiskie --automount --notify --smart-tray &"
      "hyprctl setcursor Bibata-Modern-Ice 24 &"
      "init-wallpaper &"

      "${pkgs.netbird-ui}/bin/netbird-ui"
      "${pkgs.nextcloud-client}/bin/nextcloud --background"
      "${pkgs.rssguard}/bin/rssguard"
      "${pkgs.element-desktop}/bin/element-desktop --hidden"
    ])
  ];
}
