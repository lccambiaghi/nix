{ config, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  # On-disk repo path so the symlink targets the live file (not the nix store),
  # making settings.json editable from within VSCode without a rebuild.
  nixConfigDirectory = "${config.home.homeDirectory}/.config/nix";
in
{
  home.file."Library/Application Support/Code/User/settings.json".source =
    mkOutOfStoreSymlink "${nixConfigDirectory}/home/vscode-settings.json";
}
