{ lib, ... }:
{
  options.flake.lib.diskoLayoutFactory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
