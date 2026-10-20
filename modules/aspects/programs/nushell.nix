let
  feature = "nushell";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          nushell
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        programs.nushell = {
          enable = true;
        };
      };
  };

}
