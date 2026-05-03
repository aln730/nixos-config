{ pkgs, ... }: {
  home.username = "zxcv";
  home.homeDirectory = "/home/zxcv";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    htop fzf bat eza ripgrep
  ];

  programs.git = {
    enable = true;
    userName = "aln730";
    userEmail = "arnsg730@proton.me";
  };
}