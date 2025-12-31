{inputs, ...}: let
  moduleName = "applications/zen-browser";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      imports = [
        inputs.zen-browser.homeModules.twilight
      ];
      programs.zen-browser = {
        enable = true;
        profiles."default".extensions.force = true;
        nativeMessagingHosts = with pkgs; [
          firefoxpwa
        ];
      };
    };
  };
}
