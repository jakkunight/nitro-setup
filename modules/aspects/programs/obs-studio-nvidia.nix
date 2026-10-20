let
  feature = "obs-studio-nvidia";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ den.aspects.obs-studio.nixos ];
        programs.obs-studio = {
          package = pkgs.obs-studio.override {
            cudaSupport = true;
          };
        };
      };
    homeManager =
      { pkgs, ... }:
      {
        imports = [ den.aspects.obs-studio.homeManager ];
        programs.obs-studio = {
          package = pkgs.obs-studio.override {
            cudaSupport = true;
          };
        };
      };
  };
}
