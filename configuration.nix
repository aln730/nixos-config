# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zxcv = {
    isNormalUser = true;
    description = "zxcv";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Enable sudo without password (optional)
  security.sudo.extraRules = [
    {
      users = [ "zxcv" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Enable experimental nix features like flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install system-wide packages
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    fastfetch
    htop
    tmux
    python3
    go
    gcc
    clang
    rustup
    nodejs
    cmake
    unzip
    zip
    file
    bat
    eza
    ripgrep
    fd
    fzf
    lazygit
    gh
    nix-output-monitor
    neovim
  ];

  # Enable OpenSSH for remote access
  services.openssh.enable = true;

  # Enable Flatpak (optional)
  services.flatpak.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable zsh and oh-my-zsh
  programs.zsh.enable = true;
  programs.oh-my-zsh = {
    enable = true;
    customPkgs = with pkgs; [ git fastfetch ];
    theme = "agnoster";
    plugins = [ "git" "python" "docker" ];
    enableZshCompletion = true;
  };

  # Enable firewall and open common ports
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedUDPPorts = [ ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "25.05"; # Did you read the comment?

  # Enable XFCE desktop environment
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };

}
