{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };

    # caskArgs.no_quarantine = true;
    global.brewfile = true;

  };
}
