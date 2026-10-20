let
  feature = "bat";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
      programs.bat = {
        enable = true;
      };
    };
    homeManager = {
      programs.bat = {
        enable = true;
      };
    };
  };

}
