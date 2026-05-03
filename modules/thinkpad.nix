{ pkgs, ... }: {
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  services.fwupd.enable = true;
  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = true;

  environment.systemPackages = with pkgs; [
    acpi
  ];
}