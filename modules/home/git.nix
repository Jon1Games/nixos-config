{ pkgs, username, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Jon1Games";
        email = "118659471+Jon1Games@users.noreply.github.com";

      };

      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      pull.ff = "only";
      color.ui = true;

      url = {
        "git@github.com:".insteadOf = [
          "gh:"
          "https://github.com/"
        ];
        "git@github.com:GamingLounge-me/".insteadOf = "gl:";
	"git@github.com:Jon1Games/".insteadOf = "js:";
      };

      core.excludesFile = "/home/${username}/.config/git/.gitignore";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = false;

    options = {
      line-numbers = true;
      side-by-side = true;
      diff-so-fancy = true;
      navigate = true;
    };
  };

  home.packages = with pkgs; [
    gh
    serie
    diffnav
  ];

  xdg.configFile."git/.gitignore".text = ''
    .vscode
    .direnv
  '';

  programs.zsh.shellAliases = {
    g = "lazygit";
  };
}
