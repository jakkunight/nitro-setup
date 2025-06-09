{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
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
            devices = ["nvme0n1"];
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
