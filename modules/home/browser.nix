{ inputs, pkgs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  programs.firefox.policies = {
    DisablePasswordSaving = true;
  };
}
