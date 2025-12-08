{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    # caskArgs.no_quarantine = true;
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    brews = [
      "cmake"
      "npm"
      "emacs-plus@30"
      "ffmpeg"
      "libtool"
      "nixfmt"
      # "pyright"
      # "ruff"
      "shellcheck"
      "tree-sitter"
      "qwen-code"
      "uv"
    ];
    casks = [
      "amethyst"
      "antigravity"
      "brave-browser"
      "cursor"
      "embyserver"
      "docker"
      "google-cloud-sdk"
      "iina"
      "jordanbaird-ice"
      "logseq"
      "maccy"
      # "private-internet-access"
      # "qbitorrent"
      "spotify"
      "stats"
      "telegram"
      "visual-studio-code"
    ];
    taps = [
      "d12frosted/emacs-plus"
    ];
  };
}
