let
  moduleName = "zen-browser";
in
  {inputs, ...}: {
    flake.homeModules.${moduleName} = {pkgs, ...}: {
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
  }
