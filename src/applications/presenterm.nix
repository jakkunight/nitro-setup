let
  feature = "presenterm";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          presenterm
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          presenterm
        ];
      };
  };
}
