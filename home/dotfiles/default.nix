{ config, pkgs, ... }:

{
  home.file = {
    amethyst = {
      source = ./amethyst.yml;
      target = ".amethyst.yml";
    };
    ".lintr".text = ''
linters: with_defaults(
  line_length_linter(120),
  commented_code_linter = NULL
)
exclude: "# Exclude Linting"
exclude_start: "# Begin Exclude Linting"
exclude_end: "# End Exclude Linting"
    '';
  };
  # xdg = {
  #   enable = true;
  # };
}
