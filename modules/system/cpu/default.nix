{
  config,
  lib,
  ...
}: let
  cfg = config.modules.system.hardware.cpu;

  # CPU vendors and their configuration path
  cpuVendors = {
    intel = "configurations/system/hardware/cpu/intel";
    amd = "configurations/system/hardware/cpu/amd";
  };

  # Validate and select path
  selectedPath =
    cpuVendors.${cfg.vendor}
    or (throw "CPU vendor '${cfg.vendor}' is not supported.");

  # Read configurations available in the selected path
  configurations =
    builtins.attrNames (lib.attrsets.readDir ./../../../${selectedPath});
in {
  options.modules.system.hardware.cpu = {
    enable = lib.mkEnableOption "Enable CPU hardware module";

    vendor = lib.mkOption {
      type = lib.types.enum (builtins.attrNames cpuVendors);
      default = "intel";
      description = "Which CPU vendor to use (e.g. intel, amd)";
    };

    configuration = lib.mkOption {
      type = lib.types.enum configurations;
      default = "default";
      description = "Which configuration to load for the selected CPU vendor.";
    };
  };

  config = lib.mkIf cfg.enable {
    imports = [
      (import (./../../../${selectedPath} + "/${cfg.configuration}.nix"))
    ];
  };
}
