let
  user = "jakku";
in
{ den, ... }:
{
  den.aspects."${user}-os".nixos =
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
            core
            gaming
            libvirt
            andescada
            asciinema
            obs-studio-nvidia
            podman
            wireshark
            multimedia-production
            devenv
            hermes-agent
            scarlett2-firmware
            nmap
            gparted
            ntfs3g
            exfat-progs
            nemo
            anydesk
            handy
            wtype
            llama-cpp
            opencode
            openspec
          ];

      environment.systemPackages = with pkgs; [
        pi-coding-agent
        portaudio
        typstPackages.mmdr
        typstPackages.oxdraw
        markless
        rustscan
        netscanner
        netscan
        droidcam
        termusic
      ];

      environment.sessionVariables = {
        EDITOR = "hx";
      };

      nix.settings = {
        trusted-users = [ "${user}" ];
      };
    };
}
