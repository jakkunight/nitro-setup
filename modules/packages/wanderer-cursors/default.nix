let
  package = "wanderer-cursors";
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
          runHook preInstall
          mkdir -p $out/share/icons
          install -dm 0755 $out/share/icons
          cp -R "$src/Wanderer" $out/share/icons

          runHook postInstall
        '';
      };
    };
}
