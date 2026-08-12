let
  package = "drift";
in
{
  perSystem =
    { pkgs, lib, ... }:
    let
      qtEnv =
        with pkgs.qt6;
        env "qt-custom-${qtbase.version}" [
          qtdeclarative
        ];
    in
    {
      packages.${package} = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "drift";
        version = "0.2.0";
        __structuredAttrs = true;
        strictDeps = true;

        src = pkgs.fetchFromGitHub {
          owner = "CutWire-Studios";
          repo = "Drift";
          tag = "v${finalAttrs.version}";
          hash = "sha256-L3icaBrh2DKRQDh5JTDknW+XgBAcICNp6iijM73j2Yw=";
        };

        nativeBuildInputs = with pkgs; [
          cmake
          zstd
          openssl_3
          ffmpeg
          qt6Packages.wrapQtAppsHook
          qt6Packages.qtbase
          qt6Packages.qtmultimedia
          qt6Packages.qt5compat
          qt6Packages.qtdeclarative
          # qt5.qtquickcontrols2
          soundtouch
          juce.src
          git
          pkg-config
          qtEnv
          libglvnd
        ];

        buildInputs = with pkgs; [
          qt6Packages.qtbase
          qt6Packages.qtmultimedia
          qt6Packages.qt5compat
          qt6Packages.qtdeclarative
          ffmpeg
          onnx
          onnxruntime
          soundtouch
          juce.src
          pkg-config
        ];

        cmakeFlags = [ "-DDRIFT_JUCE_DIR=${pkgs.juce.src}" ];

        passthru.updateScript = pkgs.nix-update-script { };

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
