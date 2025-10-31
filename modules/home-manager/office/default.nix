{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    hunspell
    openssl
    nssTools
    gnupg
    onlyoffice-desktopeditors
    zathura
    tdf
    mate.atril
    texliveFull
    pandoc
  ];
}
