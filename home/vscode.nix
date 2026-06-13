{ lib, ... }:
let
  settingsJson = builtins.toJSON {
    "claudeCode.preferredLocation" = "panel";
    "workbench.colorTheme" = "Quiet Light";
    "terminal.integrated.mouseWheelScrollSensitivity" = 3;
    "vim.useSystemClipboard" = true;
  };
  settingsPath = "Library/Application Support/Code/User/settings.json";
in
{
  home.activation.vscodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="$HOME/${settingsPath}"
    if [ -L "$target" ]; then
      rm "$target"
    fi
    if [ ! -f "$target" ]; then
      mkdir -p "$(dirname "$target")"
      cat > "$target" << 'SETTINGS'
    ${settingsJson}
    SETTINGS
    fi
  '';
}
