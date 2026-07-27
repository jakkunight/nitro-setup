let
  feature = "llama-cpp";
  
in
{ inputs, ... }: {
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      services = {
        llama-cpp = {
          enable = true;
          package = (pkgs.llama-cpp.override { cudaSupport = true; });
          settings = {
            ctx-size = 262144;
          };
        };
      };
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (llama-cpp.override { cudaSupport = true; })
      ];
    };
}