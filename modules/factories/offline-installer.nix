{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.factory.mkOfflineInstaller =
    {
      name ? throw "You must provide a valid host name",
      system ? "x86_64-linux",
    }:
    (inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        self.modules.nixos.${name}
        (
          { pkgs, modulesPath, ... }:
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
            nixpkgs.hostPlatform = lib.mkDefault system;
            networking.hostName = "${name}-offline-installer";
            system.stateVersion = "26.05";
            programs.nh.enable = true;
            programs.git.enable = true;

            system.includeBuildDependencies = true;

            environment.systemPackages = with pkgs; [
              gitui
              inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager
              inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
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
        )
      ];
    });
}
