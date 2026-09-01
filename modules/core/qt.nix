{ pkgs, ... }: {
  home.packages = with pkgs; [
    qt5ct
    qt6ct
    adwaita-qt
    adwaita-qt6
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    style=Fusion
    color_scheme_path=${pkgs.qt5ct}/share/qt5ct/colors/darker.conf
  '';

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    style=Fusion
    color_scheme_path=${pkgs.qt6ct}/share/qt6ct/colors/darker.conf
  '';
}
