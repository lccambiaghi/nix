{ ... }:
{
  home.file."Library/Application Support/Code/User/settings.json" = {
    force = true;
    text = builtins.toJSON {
      "claudeCode.preferredLocation" = "panel";
      "workbench.colorTheme" = "Quiet Light";
      "terminal.integrated.mouseWheelScrollSensitivity" = 3;
      "vim.useSystemClipboard" = true;
    };
  };
}
