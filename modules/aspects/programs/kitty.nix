let
  feature = "kitty";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          kitty
        ];
      };
    homeManager = _: {
      programs.kitty = {
        enable = true;
      };
    };
  };

}
