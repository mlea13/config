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
    signal-desktop
    tmux
    unzip
    vim
    wget
    zoom-us

    ghc
    cabal-install
    binutils
  ]) ++ [
    (import ../obelisk {}).command
  ];

  programs.bash.enable = true;
  programs.bash.sessionVariables = {
    EDITOR = "emacs -nw";
  };
  programs.bash.shellAliases = {
    sleep = "systemctl suspend";
  };

  programs.emacs.enable = true;
  programs.emacs.init = {
    enable = true;

    prelude = ''
      (add-to-list 'default-frame-alist '(font . "Source Code Pro 10"))
    '';
    
    usePackage = {

      ample-theme = {
        enable = true;
      };

      haskell-mode = {
        enable = true;
      };

      magit = {
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

  xresources.properties."Xft.dpi" = 128;
}
