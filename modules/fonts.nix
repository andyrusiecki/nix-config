{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.corefonts
      pkgs.vista-fonts
      pkgs.nerd-fonts.adwaita-mono
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.fira-mono
      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.meslo-lg
      pkgs.nerd-fonts.roboto-mono
      pkgs.nerd-fonts.sauce-code-pro
      pkgs.nerd-fonts.symbols-only
      pkgs.nerd-fonts.terminess-ttf
    ];
  };
}
