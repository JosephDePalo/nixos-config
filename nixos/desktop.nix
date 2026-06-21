{ pkgs, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      session_log = "/dev/null";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.dbus.enable = true;
  services.libinput.enable = true;
  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
