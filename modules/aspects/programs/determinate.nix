let
  feature = "determinate";
in
{ inputs, den, ... }:
{
  den.aspects.${feature}.nixos = {
    imports = [
      inputs.determinate.nixosModules.default
    ];
  };
}
