{
  config,
  lib,
  ...
}: let
  cfg = config.modules.system.hardware.boot;

  # Supported bootloaders and their configuration paths
  bootloaders = {
    systemd = "configurations/system/hardware/boot/systemd";
    grub = "configurations/system/hardware/boot/grub";
    systemd-with-grub-menu = "configurations/system/hardware/boot/systemd-with-grub-menu";
  };

  # Selected bootloader configuration path
  selectedPath =
    bootloaders.${cfg.loader}
    or (throw "Bootloader '${cfg.loader}' is not supported.");

  # Available configurations in the selected bootloader
  configurations =
    builtins.attrNames (lib.attrsets.readDir ./../../../${selectedPath});
in {
  options.modules.system.hardware.boot = {
    enable = lib.mkEnableOption "Enable bootloader module";

    loader = lib.mkOption {
      type = lib.types.enum (builtins.attrNames bootloaders);
      default = "systemd";
      description = "Which bootloader to use (systemd, grub, systemd-with-grub-menu)";
    };

    configuration = lib.mkOption {
      type = lib.types.enum configurations;
      default = "default";
      description = "Which configuration to load for the selected bootloader.";
    };

    bootDevice = lib.mkOption {
      type = lib.types.str;
      description = "The device where the bootloader is installed (e.g. /dev/nvme0n1). Use 'nodev' if GRUB is only used as a graphical menu.";
    };

    grubTheme = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Optional path to a custom GRUB theme.";
    };
  };

  config = lib.mkIf cfg.enable {
    imports = [
      (import (./../../../${selectedPath} + "/${cfg.configuration}.nix"))
    ];
  };
}
