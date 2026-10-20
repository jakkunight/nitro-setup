let
  feature = "searxng";
in
{ den, ... }: {
  den.aspects.${feature}.nixos = { pkgs, lib, ... }: {
    services.searx = {
      enable = true;
      package = pkgs.searxng;
      domain = lib.mkDefault "nixos.searxng.search";
    };
  };
}
