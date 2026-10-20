let
  feature = "foot";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          foot
        ];
      };
    homeManager = _: {
      programs.foot = {
        enable = true;
      };
    };
  };

}
