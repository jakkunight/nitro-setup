let
  feature = "devenv";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          devenv
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          devenv
        ];
      };
  };
}
