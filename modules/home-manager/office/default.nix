{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    hunspell
    openssl
    nssTools
    gnupg
    onlyoffice-bin
  ];
}
