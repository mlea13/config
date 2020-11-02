{ pkgs, ... }:

{
  imports = [./emacs-init.nix];

  nixpkgs.config = import ./nix-config.nix;
  nixpkgs.overlays = [
    (self: _: {
      gplates = self.callPackage (import ./gplates.nix) {};
    })
  ];
  
  home.packages = (with pkgs; [
    anki
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

    gimp    
#    gprojector
    gplates
    inkscape

    jre
    
    ghc
    cabal-install
    binutils

    jre
  ]) ++ [
    (import ../obelisk {}).command
  ];

  programs.bash.enable = true;
  programs.bash.sessionVariables = {
    EDITOR = "emacs -nw";
  };
  programs.bash.shellAliases = {
    sleep = "systemctl suspend";
    gproject = "_JAVA_AWT_WM_NONREPARENTING=1 ~/G.ProjectorJ/gprojector.sh";
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

  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
  
  xresources.properties."Xft.dpi" = 128;
}
