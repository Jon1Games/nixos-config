{ ... }:
{
  programs.zsh = {
    shellAliases = {
      # Utils
      c = "clear";
      cd = "z";
      cat = "bat";
      diff = "delta --diff-so-fancy --side-by-side";
      less = "bat";
      man = "batman";
      ping = "gping";
      ls = "eza --icons -a --group-directories-first -1 --no-user --long"; # EZA_ICON_SPACING=2
      tree = "eza --icons --tree --group-directories-first";

      # Nixos
      ns = "nom-shell --run zsh";
      nsp = "nom-shell --run zsh -p";
      nd = "nom develop --command zsh";
      nb = "nom build";
      nc = "nh-notify nh clean all --keep 5";
      nft = "nh-notify nh os test";
      nfs = "nh-notify nh os switch";
      nfu = "nh-notify nh os switch --update";
      nsearch = "nh search";
    };
  };
}
