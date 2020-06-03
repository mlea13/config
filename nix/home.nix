{ pkgs, ... }:

{
  imports = [./emacs-init.nix];
  
  home.packages = (with pkgs; [
    acpi
    arandr
    autorandr
    dmenu
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
  ]) ++ [
    (import ../obelisk {}).command
  ];

  programs.emacs.enable = true;
  programs.emacs.init = {
    enable = true;

    prelude = ''
      (add-to-list 'default-frame-alist '(font . "Source Code Pro 8"))
    '';
    
    usePackage = {

      haskell-mode = {
        enable = true;
      };

      nix-mode = {
        enable = true;
      };

      which-key = {
        enable = true;
        config = ''
          (which-key-mode)
        '';
      };

      company = {
        enable = true;
        config = ''
          (global-company-mode)
        '';
      };

    };
  };

  xresources.properties."Xft.dpi" = 192;
}
