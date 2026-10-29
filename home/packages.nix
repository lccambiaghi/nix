{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      awscli2
      bat
      eza
      cmake
      curl
      go
      montserrat
      vim
      htop
      ripgrep
      shellcheck
      gh
      # pre-commit secret scan, ~/cowork/.githooks/pre-commit
      gitleaks
      # document skills: pandoc extracts docx text, pdftoppm renders pages to images
      pandoc
      poppler-utils
      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      tree-sitter
      wget
    ];
  };
}
