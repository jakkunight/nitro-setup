{ config, lib, pkgs, inputs, hostname ? "nitro", ... }:
{
  # Copy the flake to the /etc/nixos-config folder (symlink):
  environment.etc."nixos".source = ./.;

  # Installer:
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixos-offline-install" ''
      nixos-install --system ${inputs.self.outputs.nixosConfigurations."${hostname}".config.system.build.toplevel}

    '')
  ];
}
