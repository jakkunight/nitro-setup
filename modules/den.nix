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
        fonts.packages = lib.mkAfter (
          with pkgs.nerd-fonts;
          [
            _0xproto
            mononoki
            hack
            caskaydia-cove
            caskaydia-mono
            profont
            bigblue-terminal
            departure-mono
            zed-mono
            terminess-ttf
            fira-code
            fira-mono
            proggy-clean-tt
            googlesanscode
          ]
        );
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
