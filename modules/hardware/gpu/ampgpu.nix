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
    amdgpuConfigType = submodule {
      options = {
      };
    };
  in {
    amdgpuConfig = mkOption {
      type = nullOr amdgpuConfigType;
      default = null;
    };
  };
  config = {
    # TODO: Configure AMD GPU support!
    flake.modules.nixos."hardware/gpu" = mkIf (config.gpuClass == "amdgpu") {};
  };
}
