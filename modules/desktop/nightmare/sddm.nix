{inputs, ...}: {
  flake.modules.nixos."desktop/nightmare/sddm" = {
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.silentSDDM.nixosModules.default
    ];
    programs.silentSDDM = {
      enable = true;
      theme = "default";
      backgrounds = {
        "9s-wallpaper" = toString (config.stylix.image); # 9s-wallpaper.jpg
      };
      profileIcons = builtins.mapAttrs (username: userdata: "${userdata.home}/.face") (
        lib.filterAttrs (username: userdata: userdata.isNormalUser || username == "root") config.users.users
      );
      settings = {
        "LoginScreen" = {
          background = "9s-wallpaper.jpg";
        };
        "LockScreen" = {
          background = "9s-wallpaper.jpg";
        };
      };
    };
  };
}
