{inputs, ...}: {
  imports = [
    inputs.textfox.homeManagerModules.default
  ];
  textfox = {
    enable = true;
    profile = "default";
    config = {
      # Optional config
    };
  };
  programs.firefox = {
    enable = true;
    profiles."default".extensions.force = true;
  };
}
