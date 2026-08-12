let
  package = "drift";
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${package} =
        {
          lib,
          stdenv,
          fetchFromGitHub,
          cmake,
          nix-update-script,
        }:

        stdenv.mkDerivation (finalAttrs: {
          pname = "drift";
          version = "0.2.0";
          __structuredAttrs = true;
          strictDeps = true;

          src = fetchFromGitHub {
            owner = "CutWire-Studios";
            repo = "Drift";
            tag = "v${finalAttrs.version}";
            hash = "sha256-L3icaBrh2DKRQDh5JTDknW+XgBAcICNp6iijM73j2Yw=";
          };

          nativeBuildInputs = [
            cmake
          ];

          passthru.updateScript = nix-update-script { };

          meta = {
            description = "Drift is a free, open-source, beginner-friendly desktop video editor built with Qt 6 and FFmpeg";
            homepage = "https://github.com/CutWire-Studios/Drift";
            changelog = "https://github.com/CutWire-Studios/Drift/blob/${finalAttrs.src.rev}/CHANGELOG.md";
            license = lib.licenses.gpl3Only;
            maintainers = with lib.maintainers; [ ];
            mainProgram = "drift";
            platforms = lib.platforms.all;
          };
        });
    };
}
