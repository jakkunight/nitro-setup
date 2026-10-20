let
  feature = "ollama";
  extra-feature = "ollama-cuda";
  extra-feature-2 = "ollama-vulkan";

in
{ inputs, den, ... }: {
  den.aspects.${feature} = {
    nixos =
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
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          llama-swap
          # vllm
          llmfit
        ];
        # Removed services.ollama
      };
  };
  den.aspects.${extra-feature} = {
    nixos =
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
    homeManager =
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
  };
  den.aspects.${extra-feature-2} = {
    nixos =
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
    homeManager =
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
  };

}
