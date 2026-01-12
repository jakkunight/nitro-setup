_: let
  moduleName = "terminal/utils/coreutils";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        (uutils-coreutils.override {prefix = "";})
        ripgrep
        ripgrep-all
        mprocs
        fd
        xh
        dua
        dust
        fselect
        delta
      ];
    };
  };
}
