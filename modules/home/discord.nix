{ pkgs, ... }:
{
  home.packages = with pkgs; [
    webcord		# Pricavy & Discord Terms of Servive (no mods)
    # vesktop		# Vencord (mods)
  ];
}
