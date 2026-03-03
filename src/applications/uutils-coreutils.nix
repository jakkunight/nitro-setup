let
  feature = "uutils-coreutils";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          (uutils-coreutils.override { prefix = ""; })
          ripgrep
          ripgrep-all
          fd
          xh
          dust
          delta
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          (uutils-coreutils.override { prefix = ""; })
          ripgrep
          ripgrep-all
          mprocs
          fd
          xh
          dua
          dust
          fselect
          delta
        ];
      };
  };
}
