{ pkgs, ... }:

{
  imports = [
    ./emacs-init.nix
    ./anki.nix
    ./mpv.nix
  ];

  nixpkgs.config = import ./nix-config.nix;

  home.packages = (with pkgs; [
    anki
    acpi
    arandr
    autorandr
    dmenu
    element-desktop
    (hunspellWithDicts [ hunspellDicts.en-us-large ])
    firefox
    geoclue2
    gnome3.gnome-screenshot
    google-chrome
    konsole
    libreoffice
    pavucontrol
    redshift
    signal-desktop
    tmux
    transmission-gtk
    unar
    unzip
    vim
    wget
    xclip
    zoom-us

    (gimp-with-plugins.override { plugins = with gimpPlugins; [ gmic ]; })
    gplates
    inkscape

    ghc
    cabal-install
    binutils
    stylish-haskell
    haskellPackages.cabal-fmt

    jre
  ]) ++ [
    (import ../obelisk {}).command
    (import ./home-manager { inherit pkgs; }).home-manager
  ];

  programs.bash.enable = true;
  programs.bash.sessionVariables = {
    EDITOR = "emacs -nw";
  };
  programs.bash.shellAliases = {
    sleep = "systemctl suspend";
    gproject = "_JAVA_AWT_WM_NONREPARENTING=1 ~/G.ProjectorJ/gprojector.sh";
  };

  programs.git.enable = true;
  programs.git.ignores = [ "*~" ];
  programs.git.userName = "Maddy Lea";
  programs.git.userEmail = "maddy.lea@gmail.com";
  programs.git.delta.enable = true;

  programs.emacs.enable = true;
  programs.emacs.init = {
    enable = true;

    prelude = builtins.readFile ./prelude.el;
    postlude = builtins.readFile ./postlude.el;

    usePackage = {

      ample-theme = {
        enable = true;
        config = "(ample-theme)";
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

      uuidgen = {
        enable = true;
      };

      org = {
        enable = true;
      };

      wc-mode  = {
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

  xsession.enable = true;
  xsession.initExtra = ''
    ibus-daemon &
  '';
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config = ../dotfiles/xmonad.hs;

  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
