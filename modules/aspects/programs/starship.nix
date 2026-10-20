let
  feature = "starship";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos = {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = true;
        };
      };
    };
    homeManager = {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = true;
        };
      };
    };
  };

}
