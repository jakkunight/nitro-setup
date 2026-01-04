_: let
  moduleName = "applications/zed-editor";
in {
  flake.modules = {
    homeManager.${moduleName} = {pkgs, ...}: {
      programs.zed-editor = {
        enable = true;
        extraPackages = with pkgs; [
          nixd
          nil
        ];
        package = pkgs.zed-editor;
      };
    };
  };
}
