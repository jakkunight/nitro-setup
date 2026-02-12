let
  packageName = "profiles";
in {
  perSystem = {pkgs, ...}: {
    packages."${packageName}" = pkgs.stdenvNoCC.mkDerivation {
      name = "${packageName}";
      src = ./.;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/profiles
        cp -r $src/* $out/share/profiles
      '';
    };
  };
}
