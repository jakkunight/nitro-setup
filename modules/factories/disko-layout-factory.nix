{ lib, ... }:
{
  options.flake.diskoLayoutFactory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
