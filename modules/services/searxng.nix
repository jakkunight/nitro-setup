let
  feature = "searxng";
in
_: {
  flake.modules.nixos.${feature} = { pkgs, lib, ... }: {
    services.searx = {
      enable = true;
      package = pkgs.searxng;
      domain = lib.mkDefault "nixos.searxng.search";
    };
  };
}
