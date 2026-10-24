{ pkgs, ... }:
{
  home.packages = with pkgs; [
    webcord		# Pricavy & Discord Terms of Servive (no mods)
    # vesktop		# Vencord (mods)
  ];

  # Configure XDG portal permissions to allow screen sharing by default
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [webcord]
    UseIn=
  '';

  # Create webcord config directory with settings
  home.file.".config/webcord/session-config.json" = {
    text = ''
      {
        "screenshare": {
          "allowPersistentPermissions": true
        }
      }
    '';
  };
}

