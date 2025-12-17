{inputs, ...}: {
  flake.modules.nixos."nh" = _: {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
  };
  flake.modules.home."nh" = _: {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
  };
}
