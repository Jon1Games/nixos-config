{ pkgs, host, ... }:
{
  services.netbird = {
    enable = true;
    useRoutingFeatures = "client";
  };

  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    nameservers = [
      "192.168.178.106"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
      ];
    };
    networkmanager.plugins = with pkgs; [
      networkmanager-sstp
    ];
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wireguard-tools
  ];
}
