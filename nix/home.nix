{ pkgs, ... }:

{
  home.packages = with pkgs; [
    arandr
    autorandr
    dmenu
    emacs
    firefox
    geoclue2
    gitFull    
    google-chrome
    home-manager
    libreoffice
    pavucontrol
    redshift
    tmux
    unzip
    vim
    wget 
  ];
}