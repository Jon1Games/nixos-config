{ config, pkgs, lib, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableRedistributableFirmware = true;
    opentabletdriver.enable = true;
  };

  systemd.services.g29-midi-bridge = {
    description = "Logitech G29 mappings";
    wantedBy = [ "multi-user.target" ];
    after = [ "sound.target" ];
    
    path = [
      (pkgs.python3.withPackages (ps: [
        ps.evdev
        ps.mido
        ps.python-rtmidi
      ]))
    ];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "3s";
      ExecStart = pkgs.writers.writePython3 "g29-mappings.py" {
        libraries = with pkgs.python3Packages; [ evdev mido python-rtmidi ];
      } ''
        import sys
        from evdev import InputDevice, ecodes
        import mido
        
        #############
        # VARIABLES #
        #############
        MIDI_CHANNEL = 0
        MIDI_CC_mod = 1           # mod wheel
        MIDI_CC_expression = 11   # expression pedal
        MIDI_CC_sustain = 64      # sustain pedal
        
        def find_g29_device():
            device_paths = evdev.list_devices() 
            for path in device_paths:
                try:
                    dev = InputDevice(path)
                    if "logitech g29" in dev.name.lower():
                        return dev
                except (PermissionError, FileNotFoundError):
                    continue
            return None

        print("Scanning system for Logitech G29 Racing Wheel...", flush=True)
        device = find_g29_device()
        if not device:
            sys.exit(1)
        print(f"Successfully auto-detected device at: {device.path} ({device.name})", flush=True)
        
        try:
            output = mido.open_output('G29 Gas Pedal', virtual=True)
            
            ##########
            # INPUTS #
            ##########
            for event in device.read_loop():
                # gas pedal
                if event.type == ecodes.EV_ABS and event.code == 2:
                    # 8 bit -> 7 bit and inverting
                    midi_value = 127 - int((event.value / 255.0) * 127.0)
                    msg = mido.Message('control_change', channel=MIDI_CHANNEL, control=MIDI_CC_sustain, value=midi_value)
                    output.send(msg)
                # break pedal
                # clutch pedal
                # steering wheel

            ##########
        except Exception as e:
            print(f"Error encountered: {e}", file=sys.stderr)
            sys.exit(1)
      '';
    };
  };
}
