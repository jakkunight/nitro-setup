let
  package = "wanderer-wallpapers";
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${package} = pkgs.stdenvNoCC.mkDerivation {
        name = "${package}";
        src = ./.;
        dontBuild = true;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/wallpapers
          cp -R $src/* $out/share/wallpapers
        '';
      };
    };
}
