{ primaryUser, ... }:
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "built-in-stubs.jar"
      "dumb.rdb"
      ".elixir_ls/"
      ".vscode/"
      "npm-debug.log"
      "shell.nix"
      ".direnv/*"
    ];

    settings = {
      user = {
        name = "Luca Cambiaghi";
        email = "luca.cambiaghi@me.com";
      };
      alias = {
        co = "checkout";
        d = "diff";
        s = "status";
        pr = "pull --rebase";
        pra = "pull --rebase --autostash";
        st = "status";
        l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      };
      # github = {
      #   user = primaryUser;
      # };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
