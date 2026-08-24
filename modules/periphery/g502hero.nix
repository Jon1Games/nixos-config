{ config, pkgs, ... }:

{
  # Because ratbagd is designed to flash the onboard memory once, it does not accept static 
  # text declarations natively in configuration.nix. This custom systemd service runs once 
  # on startup, checks for the Logitech G502 HERO, and provisions your configuration.
  systemd.services.provision-g502-hero = {
    description = "Provision Logitech G502 HERO Mouse Profiles via ratbagctl";
    documentation = [ "https://github.com/libratbag/libratbag" ];
    after = [ "ratbagd.service" ];
    wants = [ "ratbagd.service" ];
    wantedBy = [ "multi-user.target" ];
    
    script = ''
      # Give ratbagd daemon a brief window to initialize and discover USB nodes
      sleep 5

      # Find target device ID safely without throwing hard script exits if disconnected
      MOUSE_ID=$(${pkgs.libratbag}/bin/ratbagctl list | grep -i "G502" | head -n 1 | cut -d: -f1 || true)

      if [ -n "$MOUSE_ID" ]; then
        echo "Found Logitech G502 HERO at node: $MOUSE_ID. Applying configuration..."
        
        # Performance Constraints (800 DPI, 1000Hz Refresh State)
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" dpi set 800
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" rate set 1000

        # Keep Core Pointer Interactivity
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 0 action set button 1     # Left Click
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 1 action set button 2     # Right Click
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 2 action set button 3     # Middle Click
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 5 action set scroll-left  # Tilt Wheel Left
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 6 action set scroll-right # Tilt Wheel Right

        # Strip Auxiliary Key Interrupts (Disable Side, G-keys, and Sniper toggles)
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 3 action set disable      # Side Back
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 4 action set disable      # Side Forward
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 7 action set disable      # G8 (DPI Up)
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 8 action set disable      # G7 (DPI Down)
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 9 action set disable      # G9 (Profile)
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" button 10 action set disable     # G6 (Sniper)

        # Apply Muted Rimuru Slime Blue Aesthetics (#5dade2)
        # Note: Index configurations vary depending on specific hardware revisions; flashing both covers logos and rings.
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" led 0 text-color 5dade2 || true
        ${pkgs.libratbag}/bin/ratbagctl "$MOUSE_ID" led 1 text-color 5dade2 || true
        
        echo "Logitech G502 HERO provisioned successfully."
      else
        echo "Logitech G502 HERO mouse not detected on boot. Skipping configuration."
      fi
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
