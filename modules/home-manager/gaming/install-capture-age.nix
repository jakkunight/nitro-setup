{pkgs, ...}: let
  steam_gid = "813780";
  ca_setup = "$HOME/Downloads/CaptureAgeSetup.exe";
in
  pkgs.writeShellScriptBin "install-ca.sh" ''
    # Download CA installer:
    echo "[INFO] Downloading CA to $HOME/Downloads..."
    ${pkgs.curl}/bin/curl -fLo "${ca_setup}" "https://captureage.azureedge.net/cade/prod/CaptureAgeSetup.exe"
    echo "[INFO] Setting up env vars..."
    export STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.local/share/Steam
    export STEAM_COMPAT_DATA_PATH=$HOME/.local/share/Steam/steamapps/compatdata/${steam_gid}
    export WINEPREFIX=$HOME/.steam/steam/steamapps/compatdata/test/pfx
    echo "[INFO] Select the correct Proton version for your AoE2:DE installation:"
    select d in $HOME/.steam/root/steamapps/common/*
    do
        if [[ -n "$d" ]] && [[ -f "$d/proton" ]]; then
          break;
        else
          echo ">>> Wrong Folder Selection!!! Try Again"
        fi
    done
    echo "[INFO] Running CA installer..."
    "${pkgs.wineWowPackages.stableFull}/bin/wine64 ${ca_setup}"
    echo "[INFO] Installed CA:DE in your machine!"
    echo "[INFO] Patching WINEPREFIX..."
    ln -s "$HOME/.local/share/Steam/steamapps/common/AoE2DE" "$HOME/.local/share/Steam/steamapps/compatdata/${steam_gid}/pfx/drive_c/Program Files (x86)/Steam/steamapps/common"
    echo "[INFO] Patched!"
    echo "[INFO] Now you can use the \`run-ca.sh\` script to run CA:DE!"
  ''
