{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      bat
      eza
      cmake
      curl
      vim
      htop
      ripgrep
      shellcheck
      gh
      # pre-commit secret scan, ~/cowork/.githooks/pre-commit
      gitleaks
      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      tree-sitter
      wget
    ];
  };
}
