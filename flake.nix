# /mnt/etc/nixos/flake.nix
{
  inputs = {
    # NOTE: Replace "nixos-23.11" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations = {
      nitro = nixpkgs.lib.nixosSystem {
        # NOTE: Change this to aarch64-linux if you are on ARM
        system = "x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./hosts/nitro/configuration.nix
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          {
            nix = {
            	settings.experimental-features = [ "nix-command" "flakes" ];
            }
          }
        ];
      };
      # servers = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   extraSpecialArgs = { inherit inputs; };
      #   modules = [
      #     ./hosts/servers/configuration.nix
      #     inputs.disko.nixosModules.disko
      #     inputs.home-manager.nixosModules.home-manager
      #     {
      #       nix = {
      #         settings.experimental-features = [ "nix-command" "flakes" ]
      #       }
      #     }
      #   ];
      # };
    };
  };
}
