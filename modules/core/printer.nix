{ pkgs, ... }:

let
  secrets = import ../../secrets.nix;

in {
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      epson-escpr
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_ET-2750";
        location = "ASB";
        deviceUri = "ipp://${secrets.epson_et-2750_ip}/ipp/print";
        model = "everywhere";
      }
    ];
  };
}

