{ ... }:
{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    settings = {
      "*" = {
        controlMaster = "auto";
        controlPath = "~/.ssh/control-%r@%h:%p";
        controlPersist = "10m";

        forwardAgent = false;
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
    };
  };

  services.ssh-agent.enable = true;
}
