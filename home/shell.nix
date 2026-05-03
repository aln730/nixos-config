{ ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos-config#$(hostname)";
      ls = "eza";
      cat = "bat";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}