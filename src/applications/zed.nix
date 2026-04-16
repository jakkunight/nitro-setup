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
    homeManager.${feature} = _: {
      programs.zed-editor = {
        enable = true;
      };
    };
  };
}
