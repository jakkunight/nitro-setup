let
  feature = "qutebrowser";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          qutebrowser
        ];
      };
    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };
  };

}
