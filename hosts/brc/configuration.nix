{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "brc";

  homebrew.brews = [
    "omlx"
    "opencode"
    "pi-coding-agent"
    "uv"
  ];
  homebrew.casks = [
    "amethyst"
    "brave-browser"
    "claude-code"
    "docker-desktop"
    "emacs-plus-app"
    #"iina"
    "jordanbaird-ice"
    "libreoffice"
    # "llamabarn"
    "lm-studio"
    "logseq"
    "maccy"
    # "spotify"
    "stats"
    #"telegram"
    "visual-studio-code"
  ];
  homebrew.taps = [
    "anomalyco/tap"
    "d12frosted/emacs-plus"
    # brew tap jundot/omlx git@github.com:jundot/omlx.git
    "jundot/omlx"
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
