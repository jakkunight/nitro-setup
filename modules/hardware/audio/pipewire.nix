{inputs, ...}: {
  flake.modules.nixos."hardware/audio/pipewire" = {pkgs, ...}: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
        extraConfig."10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [
              "hsp_hs"
              "hsp_ag"
              "hfp_hf"
              "hfp_ag"
            ];
          };
        };
        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
            monitor.bluez.properties = {
              bluez5.roles = [ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]
              bluez5.codecs = [ sbc sbc_xq aac ]
              bluez5.enable-sbc-xq = true
              bluez5.hfphsp-backend = "native"
            }
          '')
        ];
        package = pkgs.wireplumber;
      };
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    environment.systemPackages = with pkgs; [
      pavucontrol
      helvum
    ];
  };
}
