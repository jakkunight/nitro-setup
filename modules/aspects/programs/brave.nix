let
  feature = "brave";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          brave
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          brave
        ];

        programs.chromium = {
          enable = true;
          package = pkgs.brave;
        };
      };
  };

}
