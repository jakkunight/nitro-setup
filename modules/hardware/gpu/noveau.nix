{
  withSystem,
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption mkIf;
in {
  options = let
    inherit (types) submodule nullOr;
    noveauConfigType = submodule {
      options = {
      };
    };
  in {
    noveauConfig = mkOption {
      type = nullOr noveauConfigType;
      default = null;
    };
  };
  config = {
    flake.modules.nixos."hardware/gpu" = mkIf (config.gpuClass == "noveau") {
      hardware.nvidia = {
        enabled = true;
        open = lib.mkForce true;
      };
    };
  };
}
