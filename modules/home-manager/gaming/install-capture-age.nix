{pkgs, ...}: let
in
  pkgs.writeShellScriptBin "install-ca.sh" ''
    ca_setup="$HOME/Downloads/CaptureAgeSetup.exe"
    download_cade() {
      echo "[INFO] Downloading CA to $HOME/Downloads..."
      # Download CA installer:
      ${pkgs.curl}/bin/curl -fLo "$ca_setup" "https://captureage.azureedge.net/cade/prod/CaptureAgeSetup.exe"
    }
    echo "[INFO] Setting up env vars..."
    export STEAMAPPS="$HOME/.local/share/Steam/steamapps"
    export STEAM_COMPAT_DATA_PATH="$STEAMAPPS/compatdata/813780"
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam"
    export WINEPREFIX="$STEAMAPPS/compatdata/813780/pfx"
    export WINEDEBUG=warn+all # This is for debug logs
    export OBS_VKCAPTURE=1 # Enable this for OBS Videogame capture
    echo "[INFO] Select the correct Proton version for your AoE2:DE installation:"
    select PROTON_EXEC in $HOME/.steam/root/steamapps/common/*
    do
        if [[ -n "$PROTON_EXEC" ]] && [[ -f "$PROTON_EXEC/proton" ]]; then
          break;
        else
          echo "[WARN] Wrong Folder Selection!!! Try Again"
        fi
    done
    echo "[INFO] Patching WINEPREFIX..."
    protontricks 813780 d3dcompiler_47
    protontricks 813780 fonts
    echo "[INFO] Patched!"
    echo "[INFO] Running CA installer..."
    "$PROTON_EXEC/proton" run "$HOME/Downloads/CaptureAgeSetup.exe"
    echo "[INFO] Installed CA:DE in your machine!"
    echo "[INFO] Now you can use the \`run-ca.sh\` script to run CA:DE!"
  ''
