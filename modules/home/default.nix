{ ... }:
{
  imports = [
    ./bat.nix                         # better commands: cat, grep, diff
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./direnv.nix		      # enviroment loader based on current directory
    ./discord.nix                     # discord
    ./fastfetch/fastfetch.nix         # fetch tool (system information)
    ./fzf.nix 			      # fuzzy finder (qucik search and filter)
    ./gaming.nix                      # packages related to gaming
    ./ghostty/ghostty.nix             # terminal (in use and opened by super + enter)
    ./git.nix                         # version control
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal (as dependency rg. for image display image in shell)
    ./lazygit.nix
    ./nemo.nix                        # file manager
    ./nvim.nix                        # neovim editor
    ./packages                        # other packages
    ./rofi/rofi.nix                   # launcher
    ./../../scripts/scripts.nix       # personal scripts
    ./ssh.nix                         # ssh config
    ./spicetify.nix                   # spotify client
    ./swaylock.nix                    # lock screen
    ./swayosd.nix                     # brightness / volume wiget
    ./swaync/swaync.nix               # notification deamon
    ./waybar                          # status bar
    ./waypaper.nix                    # GUI wallpaper picker
    ./xdg-mimes.nix                   # xdg config
    ./zsh                             # shell
    ./nextcloud.nix
    ./keepass.nix
  ];
}
