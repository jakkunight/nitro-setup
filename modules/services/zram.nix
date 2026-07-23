let
  feature = "zram";
in
{
  flake.modules = {
    nixos.${feature} = _: {
      zramSwap = {
        enable = true;
      };
    };
  };
}
