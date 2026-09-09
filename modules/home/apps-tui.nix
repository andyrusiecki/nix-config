# /etc/nixos/modules/home/cli-tools.nix
{ pkgs, ... }:

{
  programs.bluetuith.enable = true;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
    };
  };

  programs.lazydocker.enable = true;


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.spotify-player.enable = true;

  programs.yazi = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
