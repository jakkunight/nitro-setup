let
  feature = "opencode";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          opencode
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        programs.opencode = {
          enable = true;
        };
      };
  };

}
