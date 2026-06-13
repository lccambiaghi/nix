# Claude Code configuration — live-editable via out-of-store symlinks.
#
# Files live in home/claude/ in this repo and are symlinked into ~/.claude
# with mkOutOfStoreSymlink, which points the symlink at the repo checkout
# (not the read-only Nix store). That means editing ~/.claude/skills/... or
# ~/.claude/settings.json edits the repo file directly — no rebuild needed.
# Run a rebuild only when adding/removing a managed path below.
{ config, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home) homeDirectory;

  # Absolute path to this repo's checkout. mkOutOfStoreSymlink needs a real
  # filesystem path (not the Nix store) for live editing to work.
  claudeDir = "${homeDirectory}/.config/nix/home/claude";
in
{
  home.file = {
    ".claude/settings.json".source = mkOutOfStoreSymlink "${claudeDir}/settings.json";
    ".claude/CLAUDE.md".source = mkOutOfStoreSymlink "${claudeDir}/CLAUDE-USER.md";
    ".claude/skills".source = mkOutOfStoreSymlink "${claudeDir}/skills";
    ".claude/statusline-command.sh".source = mkOutOfStoreSymlink "${claudeDir}/statusline-command.sh";
  };
}
