{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "brc";

  homebrew.brews = [
    "uv"
  ];
  homebrew.casks = [
    "amethyst"
    "brave-browser"
    "docker-desktop"
    "emacs-plus-app"
    #"iina"
    "jordanbaird-ice"
    "libreoffice"
    "logseq"
    "maccy"
    "microsoft-edge"
    # "spotify"
    "stats"
    #"telegram"
    "visual-studio-code"
  ];
  homebrew.taps = [
    "d12frosted/emacs-plus"
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    programs = {
      zsh = {
        initContent = ''
          # Source shell functions
          source ${./shell-functions.sh}
        '';
      };
    };
  };
}
