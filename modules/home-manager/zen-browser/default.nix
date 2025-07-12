{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  # home.packages = [
  #   inputs.zen-browser.packages."${pkgs.system}".beta
  # ];
  programs.zen-browser = {
    enable = true;
    profiles."default".extensions.force = true;
    nativeMessagingHosts = with pkgs; [
      firefoxpwa
    ];
  };
}
