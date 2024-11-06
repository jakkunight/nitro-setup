# Utilities to manage the system:
{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    gnugrep
    jq
    fzf
    mtr
    dnsutils
    nmap
    aria2
    git
    vim
    wget
    curl
    socat
    gnused
    file
    tree
    gawk
    which
    gnupg
    zstd
    nix-output-monitor
    iperf3
    glow
    btop
    iotop
    iftop
    strace
    lsof
    ltrace
    zellij
    nnn
    # pkgs.yazi.override {
    #   _7zz = (pkgs._7zz.override { useUasm = true; });
    # }
    inputs.old-yazi.legacyPackages."x86_64-linux".yazi
    neofetch
    fastfetch
    gnupg
    micro
    glib
    brightnessctl
    xorg.xbacklight
    acpilight
    gparted
    parted
    unixtools.fdisk
    ventoy-full
    partclone
    ncdu
    du-dust
    eza
    zoxide
    mprocs
    wiki-tui

  ];
}
