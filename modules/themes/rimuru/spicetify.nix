{ pkgs, host, username, lib, ... }:
{
  home-manager.users.${username}.programs.spicetify = {
    theme = {
      name = "comfy-rimuru";
      src = pkgs.fetchFromGitHub {
        owner = "Comfy-Themes";
        repo = "Spicetify";
        rev = "b3f8a24e444521887c21be5c69fc05a498a47664";
        hash = "sha256-sqvmSXJMLE2in/cB8ZIJE/t4J5D0PKRddWECdYJjgX0=";
      };
    };
    customColorScheme = {
      text               = "e5e9f0"; 
      subtext            = "64727d"; 
      main               = "1e1e24";
      sidebar            = "1e1e24"; 
      player             = "1e1e24"; 
      card               = "4c566a"; 
      shadow             = "000000"; # Blank out canvas dropshadow overlays
      selected-row       = "4c566a";
      button             = "56b6c2"; 
      button-active      = "61afef"; 
      button-disabled    = "535965";
      sidebar-active     = "61afef"; 
      notification       = "c678dd"; 
      notification-error = "e06c75"; 
      misc               = "e5c07b"; 
    };
  };
}

