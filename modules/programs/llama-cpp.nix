let
  feature = "llama-cpp";
in
{ inputs, ... }:
{
  flake.modules.nixos.${feature} =
    { pkgs, config, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [
        (inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda)
        llmfit
      ];
      # services = {
      #   llama-cpp = {
      #     enable = true;
      #     package = (pkgs.llama-cpp.override { cudaSupport = true; });
      #     settings = {
      #       ctx-size = 262144;
      #     };
      #   };
      # };
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        (inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda)
        llmfit
      ];
    };
}
