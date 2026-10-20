let
  feature = "multimedia-production";
in
{
  inputs,
  self,
  den,
  ...
}:
{
  den.aspects.${feature}.nixos =
    { pkgs, ... }:
    {
      imports =
        with den.aspects;
        map
          (
            a:
            if builtins.isAttrs a && a ? nixos then
              (
                let
                  v = a.nixos;
                in
                if builtins.isAttrs v && v ? __contentValues then
                  { imports = map (d: d.value) v.__contentValues; }
                else
                  v
              )
            else if builtins.isAttrs a && a ? provides then
              { }
            else
              a
          )
          [
            jack
            lmms
            # inputs.musnix.nixosModules.musnix
          ];
      environment.systemPackages = with pkgs; [
        libjack2
        jack2
        qjackctl

        pavucontrol
        libjack2
        jack2
        qjackctl
        # jack2Full
        jack_capture
      ];
      security.sudo.extraConfig = ''
        moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl
      '';
      # musnix = {
      # enable = true;
      # alsaSeq.enable = true;
      # ffado.enable = true;
      # rtcqs.enable = true;
      # soundcardPciId = "00:1f.3";
      # kernel = {
      #   realtime = true;
      #   packages = pkgs.linuxPackages_latest;
      # };
      # rtirq = {
      #   enable = true;
      # resetAll = 1;
      # prioLow = 0;
      # nameList = "rtc0 snd";
      # };
      # };
    };

}
