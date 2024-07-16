{
  description = "My Setup Settings v2.1.0";

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
    # Cachix:
    # Devenv:
    # Hyprland:
    # EnvFS:
    # Nix-LD:
  };

  outputs = { self, nixpkgs, ... }@input:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nitro = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit input; };
          modules = [
            input.disko.nixosModules.disko
            input.home-manager.nixosModules.home-manager
            ./basic/config.nix
          ];
        };
      };
      # Home-Manager:
      homeConfigurations = {
        jakku = input.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/jakku/home.nix
          ];
        };
      };
    };
}
