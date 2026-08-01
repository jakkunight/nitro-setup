let
  feature = "ollama";
  extra-feature = "ollama-cuda";
  extra-feature-2 = "ollama-vulkan";

in
{ inputs, ... }: {
  flake.modules.nixos.${feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        llama-swap
        llama-swap
        lmstudio
        # vllm
        llmfit

      ];
      services = {
        # Removed ollama service block
        # Removed llama-cpp service block
      };
    };
  flake.modules.homeManager.${feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        llama-swap
        (llama-cpp.override { cudaSupport = true; })
        lmstudio
        # vllm
        llmfit
      ];
      # Removed services.ollama
    };
  # ======== OLLAMA CUDA ========
  flake.modules.nixos.${extra-feature} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        llama-swap
        (llama-cpp.override { cudaSupport = true; })
        lmstudio
        # vllm
        llmfit

      ];
      services.ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "262144";
          OLLAMA_NUM_PARALLEL = "1";
          OLLAMA_FLASH_ATENTION = "1";
          OLLAMA_MAX_LOADED_MODELS = "1";
          OLLAMA_KV_CACHE_TYPE = "q4_0";
          OLLAMA_SCHED_SPREAD = "0";
          OLLAMA_MULTIUSER_CACHE = "0";
        };
        package = pkgs.ollama-cuda;
      };
    };
  flake.modules.homeManager.${extra-feature} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        llama-swap
        (llama-cpp.override { cudaSupport = true; })
        lmstudio
        # vllm
        llmfit
      ];
      services.ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "262144";
          OLLAMA_NUM_PARALLEL = "1";
          OLLAMA_FLASH_ATENTION = "1";
          OLLAMA_MAX_LOADED_MODELS = "1";
          OLLAMA_KV_CACHE_TYPE = "q4_0";
          OLLAMA_SCHED_SPREAD = "0";
          OLLAMA_MULTIUSER_CACHE = "0";
        };
        package = pkgs.ollama-cuda;
      };
    };
  # ======== OLLAMA VULKAN ========
  flake.modules.nixos.${extra-feature-2} =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        llama-swap
        (llama-cpp.override { cudaSupport = true; })
        lmstudio
        # vllm
        llmfit

      ];
      services.ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "262144";
          OLLAMA_NUM_PARALLEL = "1";
          OLLAMA_FLASH_ATENTION = "1";
          OLLAMA_MAX_LOADED_MODELS = "1";
          OLLAMA_KV_CACHE_TYPE = "q4_k_m";
          OLLAMA_SCHED_SPREAD = "0";
          OLLAMA_MULTIUSER_CACHE = "0";
        };
        package = pkgs.ollama-vulkan;
      };
    };
  flake.modules.homeManager.${extra-feature-2} =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        llama-swap
        (llama-cpp.override { cudaSupport = true; })
        lmstudio
        # vllm
        llmfit
      ];
      services.ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "262144";
          OLLAMA_NUM_PARALLEL = "1";
          OLLAMA_FLASH_ATENTION = "1";
          OLLAMA_MAX_LOADED_MODELS = "1";
          OLLAMA_KV_CACHE_TYPE = "q4_k_m";
          OLLAMA_SCHED_SPREAD = "0";
          OLLAMA_MULTIUSER_CACHE = "0";
        };
        package = pkgs.ollama-vulkan;
      };
    };
}
