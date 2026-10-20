let
  feature = "ollama";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          llama-swap
          lmstudio
          llmfit
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          llama-swap
          llmfit
        ];
      };
  };
}
