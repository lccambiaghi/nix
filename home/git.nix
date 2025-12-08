{ primaryUser, ... }:
{
  programs.git = {
    enable = true;

    userName = "Luca Cambiaghi";
    userEmail = "luca.cambiaghi@me.com";

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      # github = {
      #   user = primaryUser;
      # };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
