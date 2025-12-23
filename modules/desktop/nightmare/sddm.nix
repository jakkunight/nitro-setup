{inputs, ...}: {
  flake.modules.nixos."desktop/nightmare/sddm" = {
    imports = [
      inputs.silentSDDM.nixosModules.default
    ];
    programs.silentSDDM = {
      enable = true;
      theme = "default";
      # settings = { ... }; see example in module
    };
  };
}
