_: {
  # State Version:
  system.stateVersion = "25.05";

  # Hostname:
  networking.hostName = "nitro";

  # Timezone:
  time.timeZone = "America/Asuncion";

  # Set Keyboard layout:
  services.xserver.xkb.layout = "latam";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_PY.UTF-8";

  # Set console settings:
  console = {
    # Setup console:
    enable = true;

    # Use XKB options on TTY:
    useXkbConfig = true;
  };

  # Disk Layout:
  modules.system.disko = {
    layout = "simple-efi";
    devices = ["nvme0n1"];
  };
}
