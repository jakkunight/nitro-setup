{pkgs, ...}: {
  # VirtManager setup:
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    qemu
    qemu-utils
    libvirt
  ];

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm = {
          enable = true;
        };
        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true; # enable copy and paste between host and guest
  };
}
