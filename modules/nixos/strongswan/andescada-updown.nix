{pkgs, ...}:
pkgs.writeShellScript "andescada-updown.sh" ''
  echo "[UPDOWN] Initilizing script..."
  case "$PLUTO_VERB" in
    up-client)
      echo "[INFO] Turning up IPSec Client..."
      echo "[INFO] Getting interface..."
      iface=lo.ipsec
      echo "[INFO] Removing DNS resolution via VPN DNS Server..."
      ${pkgs.openresolv}/bin/resolvconf -d $iface
      if [ $? -ne 0 ]; then
        echo "[WARN] Could not remove DNS resolution via VPN DNS Server."
        echo "[WARN] You can still use the VPN, but some domains might be"
        echo "[WARN] unaccessable due to security policies."
      else
         echo "[SUCCESS] VPN DNS Server resolution removed!"
      fi
      echo "[SUCCESS] The IPSec Client is UP!"
      ;;
    down-client)
      echo "[INFO] Turning down IPSec Client..."
      echo "[SUCCESS] The IPSec Client is DOWN!"
      ;;
  esac
  echo "[SUCCESS] The leftupdown command was successfully executed."
''
