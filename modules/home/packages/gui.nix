{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Multimedia
    #amberol # music player
    audacity
    gimp
    inkscape
    media-downloader
    pavucontrol
    video-trimmer
    vlc

    ## Office
    libreoffice
    gnome-calculator
    xournalpp

    ## Utility
    dconf-editor
    gnome-disk-utility
    popsicle
    mission-center # GUI resources monitor
    zenity
    dbeaver-bin

    ## remote support
    rustdesk-flutter

    ## 3d
    blender

    firefox # DRM streaming
    rssguard # RSS
    element-desktop
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.rssguard}/bin/rssguard"
    "${pkgs.element-desktop}/bin/element-desktop --hidden"
  ];
}
