{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "mbp";

  # homebrew is best for GUI apps
  # nixpkgs is best for CLI tools
  homebrew.brews = [
    "cloud-sql-proxy"
    "emacs-plus@30"
    "ffmpeg"
    "npm"
    "libheif"
    "libtool"
    "nixfmt"
    "opencode"
    # "pyright"
    # "python@3.13"
    # "ruff"
    "qwen-code"
    "uv"
  ];
  homebrew.casks = [
    "amethyst"
    "anythingllm"
    "antigravity"
    "brave-browser"
    "cursor"
    "embyserver"
    "docker-desktop"
    # "google-cloud-sdk"
    "gcloud-cli"
    "iina"
    "jordanbaird-ice"
    "lm-studio"
    "logseq"
    "maccy"
    # "macfuse"
    # "opencode-desktop"
    # "private-internet-access"
    # "qbitorrent"
    "pycharm"
    "sbx"
    "spotify"
    "stats"
    # "stremio"
    "tailscale-app"
    "telegram"
    "utm"
    "visual-studio-code"
    "supacode"
  ];
  homebrew.taps = [
    "anomalyco/tap"
    "d12frosted/emacs-plus"
    "docker/tap"
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
