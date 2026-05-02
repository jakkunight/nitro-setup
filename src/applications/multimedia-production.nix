let
  feature = "multimedia-production";
in
{
  inputs,
  self,
  ...
}:
{
  flake.modules = {
    nixos.${feature} =
      { pkgs, ... }:
      {
        imports = with self.nixos; [
          jack
          lmms
          inputs.musnix.nixosModules.musnix
        ];
        environment.systemPackages = with pkgs; [
          libjack2
          jack2
          qjackctl

          pavucontrol
          libjack2
          jack2
          qjackctl
          jack2Full
          jack_capture
        ];
        security.sudo.extraConfig = ''
          moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl
        '';
        musnix = {
          enable = true;
          alsaSeq.enable = true;
          ffado.enable = true;
          rtcqs.enable = true;
          soundcardPciId = "00:1f.3";
          kernel = {
            realtime = true;
            packages = pkgs.linuxPackages_latest;
          };
          rtirq = {
            enable = true;
            resetAll = 1;
            prioLow = 0;
            nameList = "rtc0 snd";
          };
        };
      };
  };
}
