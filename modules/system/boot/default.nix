{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
  configsPath = ../../../configs/system/boot;
  cfg = config.modules.system.boot;
  bootloaders = builtins.readDir configsPath;
  selectedBootloader = configsPath + "/${cfg.bootloader}";
  configurations = builtins.readDir selectedBootloader;
  selectedConfig = selectedBootloader + "/${cfg.configuration}";
in {
  options.modules.system.boot = {
    bootloader = mkOption {
      description = "The selected bootloader.";
      type = types.enum (builtins.attrNames bootloaders);
      default = "systemd";
    };
    configuration = mkOption {
      description = "The config for the selected bootloader.";
      type = types.enum (builtins.attrNames configurations);
      default = "default";
    };
    kernelPackage = mkOption {
      description = "The kernel package to use.";
      type = types.package;
      default = pkgs.linuxPackages_latest;
    };
  };
  config = {
    # To speed up the boot time:
    networking.dhcpcd.wait = "background";

    boot = {
      loader.${cfg.bootloader} = import selectedConfig;
      kernel.enable = true;
      kernelPackages = cfg.kernelPackage;
    };
  };
}
