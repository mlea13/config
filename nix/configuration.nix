# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ## DISK CONFIGURATION

  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./nixos-hardware/dell/xps/13-9360
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  ## NETWORK

  networking.hostName = "maddy-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;


  ## LOCALIZATION

   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  time.timeZone = "America/New_York";


  ## PACKAGES & ENV

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     emacs firefox git google-chrome tmux vim wget gitFull
   ];

  nixpkgs.config = {
    allowUnfree = true;
  };


  ## SERVICES
  
  # List services that you want to enable:

  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };

  services.locate.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  ## X11 SERVER

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;


  ## USERS

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.maddy = {
     isNormalUser = true;
     isSystemUser = false;
     uid = 1000;
     createHome = true;
     home = "/home/maddy";
     extraGroups = [
       "maddy" "wheel" "networkmanager"
     ];       
   };


  ## NIXOS

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}