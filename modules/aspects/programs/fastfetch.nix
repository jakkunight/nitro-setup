let
  feature = "fastfetch";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          fastfetch
        ];
      };
    homeManager = {
      programs.fastfetch = {
        enable = true;
      };
    };
  };

}
