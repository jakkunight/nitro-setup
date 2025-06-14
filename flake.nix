{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nixvim,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nitro = let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            disko.nixosModules.disko
            ./modules/system
            ./hosts/nitro/default.nix
          ];
        };
    };
  };
}
