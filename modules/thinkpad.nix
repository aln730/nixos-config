{ pkgs, ... }: {
  services.tlp.enable = true;
  services.fwupd.enable = true;
  services.thermald.enable = true;
  programs.light.enable = true;
  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = true;

  environment.systemPackages = with pkgs; [
    acpi
  ];
}
