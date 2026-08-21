{ pkgs, ... }: {

  home.packages = with pkgs; [
    keepassxc
  ];

  programs.firefox.enable = true;
  programs.firefox.nativeMessagingHosts = [
    pkgs.keepassxc
  ];

  services.ssh-agent = {
    enable = true;
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
  };
}
