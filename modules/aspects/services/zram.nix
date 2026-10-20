let
  feature = "zram";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = _: {
    zramSwap = {
      enable = true;
    };
  };

}
