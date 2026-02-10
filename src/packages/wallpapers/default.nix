let
  packageName = "wallpapers";
in {
  perSystem = {pkgs, ...}: {
    packages.${packageName} = pkgs.stdenvNoCC.mkDerivation {
      src = ./.;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/wallpapers
        cp -r $src/* $out/share/wallpapers
      '';
    };
  };
}
