let
  feature = "ani-cli";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ani-cli
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          ani-cli
        ];
      };
  };

}
