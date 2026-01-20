_: {
  flake.modules.nixos."hardware/printers" = {pkgs, ...}: {
    services.printing = {
      cups-pdf.enable = true;
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        hplipWithPlugin
        hp-unified-linux-driver
        hplip
        epson-escpr
        epson-escpr2
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
