{ pkgs, ... }:

{
  # Install the Nextcloud desktop client package
  home.packages = with pkgs; [ nextcloud-client ];

  # Enable the background service to autostart at login
  services.nextcloud-client = {
    enable = true;
    startInBackground = true; # Launches minimized to the system tray
  };

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "${pkgs.nextcloud-client}/bin/nextcloud --background"
      ];
    };
  };

  # Optional: Ensure XDG autostart directories exist
  # This guarantees the desktop environment picks up the service
  xdg.enable = true;
}
