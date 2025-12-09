{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      vim
      htop
      ripgrep
      gh
      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
  };
}
