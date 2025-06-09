{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkOption;
  layouts = lib.attrsets.filterAttrs (_: type: type == "directory") (builtins.readDir ../../../configs/system/disko);
in {
  options.modules.system.disko = {
    layout = mkOption {
      description = "The disk layout to use.";
      type = types.enum (builtins.attrNames layouts);
      default = "simple-efi";
    };
  };
  config = {
    imports = [
      layouts.${config.modules.system.disko.layout}
    ];
    # To avoid the bug for Disko not setting the boot device:
    boot.loader.grub.devices = [
      "nodev"
    ];
  };
}
