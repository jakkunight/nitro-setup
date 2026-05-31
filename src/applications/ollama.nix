let
  feature = "ollama";
  extra-feature = "ollama-cuda";
  extra-feature-2 = "ollama-vulkan";

in
{
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ollama
        llama-cpp-vulkan
        lmstudio
        # vllm
        llmfit

      ];
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ollama
        llama-cpp-vulkan
        lmstudio
        # vllm
        llmfit

      ];
    };
  # ======== OLLAMA CUDA ========
  flake.modules.nixos.${extra-feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ollama-cuda
        llama-cpp-vulkan
        lmstudio
        # vllm
        llmfit

      ];
    };
  flake.modules.homeManager.${extra-feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ollama-cuda
        llama-cpp-vulkan
        lmstudio
        # vllm
        llmfit

      ];
    };
  # ======== OLLAMA VULKAN ========
  flake.modules.nixos.${extra-feature-2} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ollama-vulkan
        llama-cpp-vulkan
        lmstudio
        # vllm
        llmfit

      ];
    };
  flake.modules.homeManager.${extra-feature-2} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ollama-vulkan
        llama-cpp-vulkan
        lmstudio
        # vllm
        llmfit

      ];
    };
}
