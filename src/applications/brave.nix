let
  feature = "brave";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          brave
        ];
      };
    homeManager.${feature} =
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
