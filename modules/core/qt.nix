{ pkgs, ... }: {
  home.packages = with pkgs; [
    qt5ct
    qt6ct
    adwaita-qt
    adwaita-qt6
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
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
