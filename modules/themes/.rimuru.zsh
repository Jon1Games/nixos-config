if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'emulate' '-L' 'zsh'
'builtin' 'setopt' 'no_unset'

() {
  emulate -L zsh -o extended_glob

  unsetopt prompt_subst
  autoload -Uz add-zsh-hook

  # ---- COLOR PALETTE (Rimuru Style: Cyan/Blue & Dark Slate) ----
  typeset -g POWERLEVEL9K_BACKGROUND=0
  
  # Command execution time
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=0

  # Background jobs indicator
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=0
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false

  # Nix Shell Indicator (Bright Cyan accent to match the slime aesthetic)
  typeset -g POWERLEVEL9K_NIX_SHELL_FOREGROUND=0
  typeset -g POWERLEVEL9K_NIX_SHELL_BACKGROUND=6
  typeset -g POWERLEVEL9K_NIX_SHELL_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_NIX_SHELL_VISUAL_IDENTIFIER_EXPANSION=' '

  # Context (User@Host)
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=4
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=4
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=0

  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

  # Time Segment
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=7
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=0
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
  typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=

  # General prompt behaviors
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
