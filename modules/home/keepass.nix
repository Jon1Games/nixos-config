{ pkgs, ... }: {

  home.packages = with pkgs; [
    keepassxc
  ];

  programs.firefox.enable = true;
  programs.firefox.nativeMessagingHosts.keepassxc = true;  

  services.ssh-agent = {
    enable = true;
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
  };
}
