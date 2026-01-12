_: let
  moduleName = "applications/ventoy";
in {
  flake.modules = {
    nixos.${moduleName} = {pkgs, ...}: {
      # NOTE:
      # Since the XZ-utils incident, the trust on this package is
      # questionable, so it is marked as UNFREE and INSECURE.
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.permittedInsecurePackages = [
        "ventoy-1.1.10"
        "ventoy-gtk3-1.1.07"
      ];
      environment.systemPackages = with pkgs; [
        ventoy-full
      ];
    };
  };
}
