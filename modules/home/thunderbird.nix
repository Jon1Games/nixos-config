{ pkgs, ... }:

let
  secrets = import ../../../secrets.nix;
in {
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  accounts.email.accounts = {
    workMail = {
      primary = true;
      address = secrets.workEmail;
      realName = secrets.realName;
      userName = secrets.workEmail;
      
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10; # 10 = OAuth2
        };
      };
      
      imap = {
        host = "://office365.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "://office365.com";
        port = 587;
        tls.enable = true;
      };
    };

    privateMail = {
      address = secrets.privateEmail;
      realName = secrets.realName;
      userName = secrets.privateEmail;
      
      thunderbird.enable = true;
      
      imap = {
        host = secrets.privateEmailProvider;
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = secrets.privateEmailProvider;
        port = 465;
        tls.enable = true;
      };
    };
  };

  programs.thunderbird = {
    enable = true;
    
    profiles.default = {
      isDefault = true;
      
      settings = {
        "privacy.donottrackheader.enabled" = true;
        "mail.spellcheck.inline" = true;
        "mail.spellcheck.inline.max-errors" = 100;
        "browser.tabs.remote.autostart" = true; # Wichtig für flüssiges Rendering unter Wayland
      };
    };
  };
}
