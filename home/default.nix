{ primaryUser, ... }:
{
  imports = [
    ./packages.nix
    ./git.nix
    ./shell.nix
    ./dotfiles
    ./vscode.nix
    ./mise.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };

  programs = {
    home-manager = {
      enable = true;
      path = "../home.nix";
    };
  };

  # home-manager builds an options.json for its man pages that embeds the flake
  # source without a proper store context, triggering a build warning.
  manual.manpages.enable = false;

}
