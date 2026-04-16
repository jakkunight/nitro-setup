let
  feature = "zed";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          zed-editor
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        programs.zed-editor = {
          enable = true;
        };
      };
  };
}
