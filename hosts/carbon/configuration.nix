# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "carbon";
  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    eduroam = {
      connection = {
        id = "eduroam";
        type = "wifi";
      };
      wifi = {
        mode = "infrastructure";
        ssid = "eduroam";
      };
      wifi-security = {
        key-mgmt = "wpa-eap";
      };
      "802-1x" = {
        eap = "tls";
        identity = "asg7201@rit.edu";
        client-cert = "/etc/ssl/certs/eduroam/client.crt";
        private-key = "/etc/ssl/certs/eduroam/client.key";
        ca-cert = "/etc/ssl/certs/eduroam/cacert.crt";
      };
      ipv4.method = "auto";
      ipv6.method = "auto";
    };
  };
  # Set your time zone.
  time.timeZone = "America/New_York";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.zxcv = {
    isNormalUser = true;
    description = "Arnav Gawas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  # Install firefox.
  programs.firefox.enable = true;
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    fastfetch
    zsh
  ];
  system.stateVersion = "25.11";
}
