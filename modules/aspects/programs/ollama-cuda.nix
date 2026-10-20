let
  feature = "ollama-cuda";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ den.aspects.ollama.nixos ];
        environment.systemPackages = with pkgs; [
          llama-swap
          (llama-cpp.override { cudaSupport = true; })
          lmstudio
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
        imports = [ den.aspects.ollama.homeManager ];
        home.packages = with pkgs; [
          llama-swap
          (llama-cpp.override { cudaSupport = true; })
          lmstudio
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
}
