{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
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
        deviceUri = "ipp://192.168.178.33:631/ipp/print";
        model = "epson-escpr/Epson-ET-2750_Series-epson-escpr.ppd";
      }
    ];
  };
}

