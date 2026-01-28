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
          nix-ld
          vulkan-tools
        ];
        package = pkgs.zed-editor.fhsWithPackages (
          pkgs:
            with pkgs; [
              openssl
              zlib
            ]
        );
        extensions = [
          "nix"
          "rust"
          "toml"
          "html"
          "sql"
          "xml"
          "lua"
          "csv"
          "ini"
          "qml"
          "java"
          "json5"
          "ron"
        ];
      };
    };
  };
}
