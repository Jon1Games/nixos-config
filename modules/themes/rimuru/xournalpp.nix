{ pkgs, host, username, lib, ... }:
{
  home-manager.users.${username} = {
    xdg.configFile."xournalpp/settings.xml" = {
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <settings>
          <property name="pressureSensitivity" value="true"/>
          <property name="minimumPressure" value="0.05"/>
          <property name="pressureMultiplier" value="1"/>
          <property name="zoomGesturesEnabled" value="true"/>
          <property name="selectedToolbar" value="Portrait"/>
          <property name="lastSavePath" value=""/>
          <property name="lastOpenPath" value=""/>
          <property name="lastImagePath" value=""/>
          <property name="edgePanSpeed" value="20"/>
          <property name="edgePanMaxMult" value="5"/>
          <property name="zoomStep" value="10"/>
          <property name="zoomStepScroll" value="2"/>
          <property name="displayDpi" value="-1"/>
          <property name="mainWndWidth" value="800"/>
          <property name="mainWndHeight" value="600"/>
          <property name="maximized" value="true"/>
          <property name="showToolbar" value="true"/>
          <property name="showSidebar" value="true"/>
          <property name="sidebarWidth" value="151"/>
          <property name="sidebarNumberingStyle" value="1"/>
          <property name="sidebarOnRight" value="false"/>
          <property name="scrollbarOnLeft" value="false"/>
          <property name="menubarVisible" value="true"/>
          <property name="filepathShownInTitlebar" value="false"/>
          <property name="pageNumberShownInTitlebar" value="false"/>
          <property name="numColumns" value="1"/>
          <property name="numRows" value="1"/>
          <property name="viewFixedRows" value="false"/>
          <property name="showPairedPages" value="false"/>
          <property name="layoutVertical" value="false"/>
          <property name="layoutRightToLeft" value="false"/>
          <property name="layoutBottomToTop" value="false"/>
          <property name="numPairsOffset" value="1"/>
          <property name="emptyLastPageAppend" value="disabled"/>
          <property name="defaultPaperBgColor" value="0x2E3440"/>
          <property name="defaultPaperLightBgColor" value="0x2E3440"/>
          <property name="defaultPaperType" value="graph"/>
          <property name="defaultPaperRulerColor" value="0x4C566A"/>
          <property name="gridSize" value="14.17"/>
          <property name="pageTemplate" value="xoj/template&#10;copyLastPageSettings=false&#10;copyLastPageSize=false&#10;size=595.275591x841.889764&#10;backgroundType=graph&#10;backgroundColor=#2E3440&#10;"/>
        </settings>
      '';
      force = true;
    };
    xdg.configFile."xournalpp/toolbar.ini" = {
      text = ''
        [General]
        version=1
        [Toolbars]
        ColorPalette=COLOR(0xECEFF4),COLOR(0x88C0D0),COLOR(0x8FBCBB),COLOR(0xA3BE8C),COLOR(0xEBCB8B),COLOR(0xD08770),COLOR(0xBF616A),COLOR(0xB48EAD),COLOR(0xF5C2E7),COLOR(0x4C566A)
        [Toolbar.Main]
        0=TOOL(PEN),TOOL(ERASER),TOOL(HIGHLIGHTER),SEPARATOR,SIZE(1),SIZE(2),SIZE(3),SEPARATOR,COLOR_PALETTE,SEPARATOR,UNDO,REDO
      '';
      force = true;
    };
  };
}