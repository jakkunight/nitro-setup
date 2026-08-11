let
  feature = "hermes-agent";
in
{
  inputs,
  ...
}:
{
  flake.modules.nixos.${feature} = { pkgs, ... }: {
    imports = [
      inputs.hermes-agent.nixosModules.default
    ];
    environment.systemPackages = with pkgs; [
      ddgr
      python314Packages.ddgs
    ];
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
      extraDependencyGroups = [
        "messaging"
        "matrix"
        "voice"
      ];
      extraPackages = with pkgs; [
        python314Packages.ddgs
      ];
      settings = {
        model = {
          default = "Llama-cpp";
          base_url = "http//localhost:8080/v1";
        };
        display = {
          compact = true;
          personality = "kawaii";
        };
        memory = {
          memory_enabled = true;
          user_profile_enabled = true;
        };
      };
    };
  };
}
