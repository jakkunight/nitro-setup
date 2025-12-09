{lib, ...}: {
  options = let
    inherit (lib) types mkOption;
  in {
    gpuClass = mkOption {
      type = with types;
        nullOr (enum [
          "nvidia"
          "noveau"
          "amdgpu"
        ]);
      default = null;
    };
  };
}
