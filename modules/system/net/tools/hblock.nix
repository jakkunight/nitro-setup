{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    net.tools.hblock = {
      enable = lib.mkEnableOption "Enable hblock.";
    };
  };
  config = lib.mkIf config.net.tools.hblock.enable {
    environment.systemPackages = [
      pkgs.hblock
    ];
  };
}
