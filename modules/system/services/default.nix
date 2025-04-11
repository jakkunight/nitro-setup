{
  lib,
  config,
  ...
}: {
  imports = [
    ./udisks2.nix
    ./gvfs.nix
    ./vpns
    ./flatpak.nix
    ./cups.nix
  ];
  options = {
    serv = {
      enable = lib.mkEnableOption "Enable custom services";
    };
  };
  config = lib.mkIf config.serv.enable {
    serv = {
      udisks2.enable = lib.mkDefault true;
      gvfs.enable = lib.mkDefault true;
      vpns.enable = lib.mkDefault true;
      flatpak.enable = lib.mkDefault true;
      cups.enable = lib.mkDefault true;
    };
  };
}
