{ config, pkgs, ... }:

{
  # Lower systemd timeouts to prevent hung user/system services from blocking power-off
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
    DefaultUserTimeoutStopSec=10s
  '';
}

