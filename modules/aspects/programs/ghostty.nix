let
  feature = "ghostty";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ghostty
        ];
      };
    homeManager = _: {
      programs.ghostty = {
        enable = true;
      };
    };
  };

}
