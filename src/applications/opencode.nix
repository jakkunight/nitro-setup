let
  feature = "opencode";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          opencode
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        programs.opencode = {
          enable = true;
        };
      };
  };
}
