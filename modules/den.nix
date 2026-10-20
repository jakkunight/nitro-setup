{
  inputs,
  lib,
  den,
  ...
}:
{
  imports = [
    inputs.den.flakeModule
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ];

    nixos =
      { pkgs, ... }:
      {
        system.stateVersion = lib.mkDefault "26.11";
        programs.nh.enable = lib.mkDefault true;
        programs.git.enable = lib.mkDefault true;
        environment.systemPackages = with pkgs; [
          gitui
          inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager
          inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
        ];
        environment.etc.nixos-setup.source = lib.mkDefault ../.;
      };

    homeManager = {
      home.stateVersion = lib.mkDefault "26.11";
    };
  };

  den.aspects.standalone-home.homeManager =
    { pkgs, ... }:
    {
      nix.package = pkgs.nix;
    };
}
