{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    home-manager,
    stylix,
    ...
  } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    createUsers = allowedUsers: (map (user: {
      users.users.${user} = {
        useDefaultShell = true;
        initialPassword = "${user}";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        nix.settings.trusted-users = [
          "@wheel"
          "${user}"
        ];
      };
    }) allowedUsers);
    createHosts = hosts: allowedUsers: (builtins.listToAttrs (map ({ hostname, system }: {
      name = "${hostname}";
      value = (nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          disko.nixosModules.disko
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          (./hosts + "/${hostname}")
        ] ++ createUsers allowedUsers;
      })})) hosts);
    createHomeConfiguration = allowedUsers: (builtins.listToAttrs (map (user: {
      name = 
    }) allowedUsers));
  in
  {
    nixosConfigurations = createHosts [ "nitro" ] [ "jakku" ];
  };
}
