let
  package = "colorful-icons";
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${package} = pkgs.stdenvNoCC.mkDerivation {
        name = "${package}";
        src = pkgs.fetchFromGitHub {
          owner = "L4ki";
          repo = "Colorful-Plasma-Themes";
          rev = "main";
          hash = "sha256-bC4uAHnR4xZ50nEmG4Xyr0APvgL2r0BMD6b4a8UJbD0=";
        };
        dontBuild = true;
        dontUnpack = true;
        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/icons
          cp -R "$src/Colorful Icons Themes/Colorful-Dark-Icons" $out/share/icons

          runHook postInstall
        '';
        nativeBuildInputs = with pkgs; [
          gtk3
        ];
        propagatedBuildInputs = with pkgs; [
          hicolor-icon-theme
        ];

        dontDropIconThemeCache = true;

      };
    };
}
