{ inputs, pkgs, ... }:

let
  mkExtension = shortId: uuid: {
    name = uuid;
    value = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "force_installed";
    };
  };
in {
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      name = "default";
      isDefault = true;
      
      userChrome = ''
        :root {
          --zen-primary-color: #7ba4e4 !important;
          --zen-secondary-color: #dcb35c !important;
          
          --zen-browser-bg: #141822 !important;
          --zen-dialog-bg: #1a202c !important;           
          
          --zen-colors-tertiary: #2d3748 !important;
          --main-window-background-color: #141822 !important;
          --toolbar-background: #191f2d !important;
          --tabs-border-color: transparent !important;
        }

        #TabsToolbar {
          background-color: var(--zen-browser-bg) !important;
        }

        .tab-background[selected="true"] {
          background-color: var(--zen-primary-color) !important;
          color: #0b0d13 !important; /* Dark text for contrast against the blue */
        }
      '';

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.allowTabSourceInTitlebar" = true;
      };
    };

    policies = {
      DisableTelemetry = true;
      DisablePasswordSaving = true;

      ExtensionSettings = builtins.listToAttrs [
        # uBlock Origin
        (mkExtension "ublock-origin" "uBlock0@raymondhill.net")
        
        # Dark Reader
        (mkExtension "darkreader" "addon@darkreader.org")
        
        # Don't Fuck With Paste
        (mkExtension "don-t-fuck-with-paste" "{a8331da1-5789-4bc2-bc08-16447833f2e1}")
      ];

      Preferences = {
        "layout.css.prefers-color-scheme.content" = 1; 
        "ui.systemUsesDarkTheme" = 1;
      };
    };
  };
}

