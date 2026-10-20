let
  feature = "libreoffice";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
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
    homeManager =
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
