# .zshrc

# == LOAD ENGINE =============================================
# COMPINIT (autocompleted)

autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' formats ' %F{yellow}[%b]'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'


# == PROMT ===================================================

setopt PROMPT_SUBST
PS1='%B%F{magenta}%n%f%b %B%F{red}%~%f%b%B${vcs_info_msg_0_} %b%B%F{green} '


# == HISTORY =================================================

HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt MENU_COMPLETE
setopt COMPLETE_IN_WORD 


# == PLUGINS =================================================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# == ALIAS ==================================================


if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
alias ls='eza --color=always -a'
alias ll='eza --color=always -la'

alias translate='$HOME/.local/share/translate/launcher.sh'
