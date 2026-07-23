let
  feature = "libreoffice";
in
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          libreoffice-qt
          # For PDF signing:
          nss
          # For spellcheck
          hunspell
          hunspellDicts.es_PY
          hunspellDicts.en_US
        ];
      };
    homeManager.${feature} =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          libreoffice-qt
          # For PDF signing:
          nss
          # For spellcheck
          hunspell
          hunspellDicts.es_PY
          hunspellDicts.en_US
        ];
      };
  };
}
