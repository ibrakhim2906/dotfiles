[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
HISTSIZE=100000
HISTFILESIZE=200000

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
export BAT_THEME=ansi
alias cat='batcat --paging=never'
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias fd=fdfind

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

eval `keychain --eval --agents ssh id_ed25519 --quiet`
eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash --cmd cd)"

export PATH="$PATH:/opt/nvim/bin:$HOME/vcpkg:$HOME/scripts"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
