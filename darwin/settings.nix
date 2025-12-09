{ self, ... }:
{
  # touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # system defaults and preferences
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    activationScripts.postActivation.text = ''
      # Use list view in all Finder windows by default
      # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
      defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

      # show dock on both displays
      defaults write com.apple.Dock appswitcher-all-displays -bool true

      # Show the ~/Library folder
      chflags nohidden ~/Library

      # Hot corners
      # Possible values:
      #  0: no-op
      #  2: Mission Control
      #  3: Show application windows
      #  4: Desktop
      #  5: Start screen saver
      #  6: Disable screen saver
      #  7: Dashboard
      # 10: Put display to sleep
      # Top right screen corner → Display to sleep
      defaults write com.apple.dock wvous-tr-corner -int 10
      # Top right screen corner → Display to sleep
      defaults write com.apple.dock wvous-tr-modifier -int 0
    '';

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    startup.chime = false;

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        minimize-to-application = false;
        expose-group-by-app = true;
        tilesize            = 36;
        orientation = "left";
      };

      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      finder = {
        #AppleShowAllFiles = true; # hidden files
        AppleShowAllExtensions = true; # file extensions
        _FXShowPosixPathInTitle = true; # title bar full path
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
      };

      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
        TrackpadRightClick      = true;
      };
    };
  };
}
