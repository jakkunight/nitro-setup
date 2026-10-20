{
  inputs,
  self,
  lib,
}:
{ name }:
{ pkgs, ... }:
let
  flakeOutPaths =
    let
      collector =
        visited: parent:
        lib.concatMap (
          child:
          if lib.elem child.outPath visited then
            [ ]
          else
            let
              newVisited = visited ++ [ child.outPath ];
            in
            [ child.outPath ]
            ++ (if child ? inputs && child.inputs != { } then collector newVisited child else [ ])
        ) (lib.attrValues parent.inputs);
    in
    lib.unique (collector [ ] { inputs = inputs; });
  dependencies = [
    self.nixosConfigurations.${name}.config.system.build.toplevel
    self.nixosConfigurations.${name}.config.system.build.diskoScript
    self.nixosConfigurations.${name}.config.system.build.diskoScript.drvPath
    self.nixosConfigurations.${name}.pkgs.stdenv.drvPath
    self.nixosConfigurations.${name}.pkgs.perlPackages.ConfigIniFiles
    self.nixosConfigurations.${name}.pkgs.perlPackages.FileSlurp
    (self.nixosConfigurations.${name}.pkgs.closureInfo { rootPaths = [ ]; }).drvPath
  ]
  ++ flakeOutPaths;
  closureInfo = pkgs.closureInfo { rootPaths = dependencies; };
in
{
  system.includeBuildDependencies = true;

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "disko-install-wrapper" ''
      exec ${
        inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
      }/bin/disko-install --flake "${self}#${name}" "$@"
    '')
  ];

  environment.etc = {
    nixos-setup = {
      source = "${self}";
    };
    "install-closure".source = "${closureInfo}/store-paths";
    "system-closure-path".text = "${self.nixosConfigurations.${name}.config.system.build.toplevel}";
    "system-flake".text = "${self}";
  };
}
