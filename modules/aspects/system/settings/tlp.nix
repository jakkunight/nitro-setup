let
  feature = "tlp";
in
{ den, ... }:
{
  den.aspects.${feature}.nixos = {
    services.tlp = {
      enable = true;
      pd.enable = true;
    };
  };
}
