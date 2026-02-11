let
  packageName = "wallpapers";
in {
  perSystem = {pkgs, ...}: {
    packages."${packageName}" = pkgs.stdenvNoCC.mkDerivation {
      name = "${packageName}";
      src = ./.;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/wallpapers
        cp -r $src/* $out/share/wallpapers
      '';
    };
  };
}
