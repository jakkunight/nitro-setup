{pkgs, ...}: let
in
  pkgs.writeShellScriptBin "run-ca.sh" ''
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.local/share/Steam"
    export STEAM_COMPAT_DATA_PATH="$HOME/.local/share/Steam/steamapps/compatdata/813780"
    select d in $HOME/.steam/root/steamapps/common/*
    do
        if [[ -n "$d" ]] && [[ -f "$d/proton" ]]; then
          break;
        else
          echo ">>> Wrong Folder Selection!!! Try Again"
        fi
    done
    ${pkgs.wineWowPackages.stableFull}/bin/wine64 "$HOME/.local/share/Steam/steamapps/compatdata/813780/pfx/drive_c/users/steamuser/Local Settings/Application Data/Programs/CaptureAge/CaptureAge.exe"
  ''
