{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "brc";

  homebrew.brews = [
    # "ffmpeg@7"
    "omlx"
    "opencode"
    "pi-coding-agent"
    "uv"
  ];
  homebrew.casks = [
    "amethyst"
    "brave-browser"
    "claude-code@latest"
    "docker-desktop"
    "emacs-plus-app"
    "google-chrome"
    "iina"
    "grandperspective"
    "jordanbaird-ice"
    "libreoffice"
    # "llamabarn"
    "lm-studio"
    "logseq"
    "maccy"
    "meeting-transcriber@beta"
    # "quickrecorder"
    # "spotify"
    "stats"
    #"telegram"
    "visual-studio-code"
  ];
  homebrew.taps = [
    # "anomalyco/tap"
    {
      name = "d12frosted/emacs-plus";
      trusted = true;
    }
    # brew tap jundot/omlx git@github.com:jundot/omlx.git
    {
      name = "jundot/omlx";
      trusted = true;
    }
    # "lihaoyun6/tap"
    {
      name = "pasrom/meeting-transcriber";
      trusted = true;
    }
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

    # A Chromium that Claude Code can reach. Its sandbox denies the Mach service
    # registration Chromium needs to spawn child processes, so playwright cannot
    # launch a browser from inside a tool call and every HTML check degrades to a
    # skip. A browser hosted by a process the sandbox did not start works, so keep
    # a playwright server on loopback and let the checks connect to it
    # (BRACCO_CHROMIUM_WS, set in cowork/.claude/settings.json).
    launchd.agents.playwright-server = {
      enable = true;
      config = {
        ProgramArguments = [
          "/opt/homebrew/bin/uv"
          "run"
          "--project"
          "/Users/luca/cowork/400 Skills & design/405 slides skills"
          "playwright"
          "run-server"
          "--host"
          "127.0.0.1"
          "--port"
          "3000"
        ];
        RunAtLoad = true;
        KeepAlive = true;
        StandardOutPath = "/tmp/playwright-server.log";
        StandardErrorPath = "/tmp/playwright-server.log";
      };
    };

    # The same problem for the other twin: LibreOffice starts inside the sandbox
    # but `--convert-to` never returns, so a sandboxed session can build a .pptx
    # and never look at it. Drop one in /tmp/bracco-render/in and this converts it
    # to a PDF in out/. QueueDirectories fires the job when a file lands, so
    # nothing is running the rest of the time. Chosen over driving PowerPoint,
    # which would mean granting Apple Events to every sandboxed command.
    launchd.agents.bracco-render = {
      enable = true;
      config = {
        ProgramArguments = [
          "/bin/bash"
          "/Users/luca/cowork/400 Skills & design/405 slides skills/tools/render_service.sh"
        ];
        QueueDirectories = [ "/tmp/bracco-render/in" ];
        RunAtLoad = true;
        StandardOutPath = "/tmp/bracco-render.log";
        StandardErrorPath = "/tmp/bracco-render.log";
      };
    };

    # Mail + calendar pull from legacy Outlook (AppleScript), feeding 004 email archive
    # and, through it, the 007 Briefs. Runs on the host because osascript is blocked
    # inside the sandbox. Not on a timer: the 07:00 `wiki-daily` scheduled task drops a
    # request file in the queue (make email-pull), this agent fires on it and
    # answers in queue/done. Only legacy Outlook answers Apple Events and the two modes
    # are one app, so the script flips the profile to legacy for the pull and back
    # (Outlook restarts for about a minute).
    launchd.agents.outlook-pull = {
      enable = true;
      config = {
        ProgramArguments = [
          "/bin/bash"
          "/Users/luca/cowork/000 Knowledge/004 email archive/outlook_pull_service.sh"
        ];
        QueueDirectories = [ "/Users/luca/cowork/000 Knowledge/004 email archive/resources/outlook/queue/in" ];
        StandardOutPath = "/tmp/outlook-pull.log";
        StandardErrorPath = "/tmp/outlook-pull.log";
      };
    };
  };
}
