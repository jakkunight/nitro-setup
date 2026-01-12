_: let
  moduleName = "terminal/utils/widgets";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        clock-rs
        cava
        fastfetch
        pipes-rs
        speedtest-rs
        presenterm
        chafa
        openssh
        openssl
        just
        mask
        netscanner
        clamav
        vulnix
        smartmontools
        disktui
        diskscan
        disko
        disk-filltest
        diskrsync
        testdisk
        ddrescue
        fsarchiver
        parted
        rsync
        netcat-gnu
        cryptsetup
        chntpw
        hwinfo
        flashrom
        rclone
        nvme-cli
        nvme-rs
        memtest86plus
        stress
        stress-ng
        stressapptest
        openvas-scanner
        openvas-smb
        openvpn_learnaddress
        nikto
        tcpdump
        nftables
        iptables
        snort
        suricata
        apparmor-bin-utils
        apparmor-pam
        ldapvi
        ldapdomaindump
        ldapnomnom
        ldapmonitor
        woeusb
      ];
    };
  };
}
