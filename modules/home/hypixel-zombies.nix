{ pkgs, config, lib, ... }:

let
  cfg = config.services.hypixel-zombies-macro;

  # Python Script für den Hold-to-Repeat Switch
  zombiesScript = pkgs.writers.writePython3Bin "zombies-macro" {
    libraries = [ pkgs.python3Packages.evdev ];
  } ''
    import sys
    import time
    from evdev import InputDevice, ecodes, UInput, list_devices

    # Finde die Keychron Tastatur
    devices = [InputDevice(path) for path in list_devices()]
    target_dev = None
    for dev in devices:
        if "Keychron" in dev.name or "K10" in dev.name:
            target_dev = dev
            break

    if not target_dev:
        # Fallback auf erste verfügbare Tastatur, falls Name nicht gematcht wird
        for dev in devices:
            if "keyboard" in dev.name.lower():
                target_dev = dev
                break

    if not target_dev:
        print("Keine passende Tastatur gefunden!", file=sys.stderr)
        sys.exit(1)

    print(f"Nutze Device: {target_dev.name} ({target_dev.path})")
    
    ui = UInput()
    TRIGGER_KEY = ecodes.KEY_F18  # Taste 'F' als Trigger (anpassbar)

    holding = False

    try:
        for event in target_dev.read_loop():
            if event.type == ecodes.EV_KEY and event.code == TRIGGER_KEY:
                if event.value == 1:  # Key Down
                    holding = True
                    while holding:
                        # Slot 2
                        ui.write(ecodes.EV_KEY, ecodes.KEY_2, 1)
                        ui.write(ecodes.EV_KEY, ecodes.KEY_2, 0)
                        ui.syn()
                        time.sleep(0.1)

                        # Non-blocking Event Check für Key-Up
                        try:
                            for e in target_dev.read():
                                if e.type == ecodes.EV_KEY and e.code == TRIGGER_KEY and e.value == 0:
                                    holding = False
                                    break
                        except BlockingIOError:
                            pass

                        if not holding:
                            break

                        # Slot 3
                        ui.write(ecodes.EV_KEY, ecodes.KEY_3, 1)
                        ui.write(ecodes.EV_KEY, ecodes.KEY_3, 0)
                        ui.syn()
                        time.sleep(0.1)

                elif event.value == 0:  # Key Up
                    holding = False
    except KeyboardInterrupt:
        pass
    finally:
        ui.close()
  '';
in
{
  options.services.hypixel-zombies-macro = {
    enable = lib.mkEnableOption "Hypixel Zombies Hotbar Switch Macro";
  };

  config = lib.mkIf cfg.enable {
    # Benötigte Tools im User Environment
    home.packages = [
      zombiesScript
      pkgs.ydotool
    ];

    # Systemd User Service, der das Makro im Hintergrund ausführt
    systemd.user.services.hypixel-zombies-macro = {
      Unit = {
        Description = "Hypixel Zombies Hotbar Toggle Macro Daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${zombiesScript}/bin/zombies-macro";
        Restart = "on-failure";
        RestartSec = 3;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
  services.hypixel-zombies-macro.enable = true;
}
