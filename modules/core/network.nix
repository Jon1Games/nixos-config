{ pkgs, host, ... }:
{
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

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "172.31.31.8/24" ];
      privateKeyFile = "/etc/wireguard/dumbeldore.priv";
      peers = [
        {
          publicKey = "1zeGKTo6LzsVEhtcUZy3mcl1ZRTLVWvWIT/sC2iMUn0=";
          allowedIPs = [ "172.31.31.0/24" "172.19.8.0/24" "172.19.9.0/24" ];
          presharedKeyFile = "/etc/wireguard/dumbeldore.shared";
	  endpoint = "37.114.39.172:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
