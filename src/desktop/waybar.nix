let
  feature = "waybar";
in
{ inputs, lib, ... }:
{
  flake.modules = {
    homeManager.${feature} =
      {
        config,
        pkgs,
        ...
      }:
      {
        programs = {
          waybar = {
            enable = true;
            # package = inputs.waybar-git.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
            systemd.enable = true;
          };
        };
      };
  };
}
