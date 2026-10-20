let
  feature = "uutils-coreutils";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
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
    homeManager =
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
