{
  config,
  lib,
  ...
}: let
  cfg = config.modules.system.hardware.gpu;

  vendors = {
    nvidia = "configurations/system/hardware/gpu/nvidia";
    amd = "configurations/system/hardware/gpu/amd";
  };

  selectedPath =
    vendors.${cfg.vendor}
    or (throw "GPU vendor '${cfg.vendor}' is not supported.");

  configurations =
    builtins.attrNames (lib.attrsets.readDir ./../../../${selectedPath});
in {
  options.modules.system.hardware.gpu = {
    enable = lib.mkEnableOption "Enable GPU hardware module";

    vendor = lib.mkOption {
      type = lib.types.enum (builtins.attrNames vendors);
      default = "nvidia";
      description = "Which GPU vendor to use (e.g. nvidia, amd)";
    };

    configuration = lib.mkOption {
      type = lib.types.enum configurations;
      default = "default";
      description = "Which configuration to load for the selected GPU vendor.";
    };

    bus = lib.mkOption {
      type = lib.types.nullOr lib.types.nonEmptyStr;
      default = null;
      description = "The PCI bus used by the GPU (optional override).";
    };
  };

  config = lib.mkIf cfg.enable {
    imports = [
      (import (./../../../${selectedPath} + "/${cfg.configuration}.nix") {inherit config;})
    ];
  };
}
