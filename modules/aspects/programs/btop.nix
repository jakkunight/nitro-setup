let
  feature = "btop";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          btop
        ];
      };
    homeManager = {
      programs.btop = {
        enable = true;
      };
    };
  };

}
