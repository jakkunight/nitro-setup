{
  description = "My Setup Settings v2.1.0";

  # Enable Cachix:
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Nixpkgs:
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home Manager:
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko:
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Devenv:
    # Hyprland:
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # EnvFS:
    # Nix-LD:
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations = {
        nitro = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs.inputs = inputs;
          modules = [
            inputs.disko.nixosModules.disko
            ./disk/disk.nix
            { _module.args.disks = [ "/dev/nvme0n1" ]; }
            ./basic/config.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };
      # Home-Manager:
      homeConfigurations = {
        jakku = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/jakku/home.nix
          ];
        };
      };
    };
}
