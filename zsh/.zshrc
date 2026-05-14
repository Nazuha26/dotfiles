# ===== HISTORY SETUP =====
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt interactivecomments



# ===== COMPLETION =====
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
bindkey -e



# ===== ENVIRONMENT VARIABLES =====
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/.local/bin"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"



# ===== ALIASES =====
# === System & Navigation ===
alias ls='ls --color=auto'
alias ll='ls -lahF'   # sort by alphabet
alias lls='ls -lahFS' # sort by size (Bigger -> Lower)
alias llt='ls -lahFt' # sort by time (Newer -> Older)
alias llx='ls -lahFX' # sort by extension

alias tree='tree -aF'
alias treel='tree -aF -L' # set tree level

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# === Dev ===
alias gtdc='cd ~/dev/education/clab'
alias m='micro'

# === Project Nox ===
alias knox='killall -9 nox_client java; rm -rf ~/projects/nox/server/target'



# ===== FZF INTEGRATION =====
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export FZF_DEFAULT_COMMAND='fdfind --hidden --exclude .git'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_ALT_C_COMMAND="fdfind --type d --hidden --exclude .git"



# ===== STARSHIP =====
eval "$(starship init zsh)"



# ===== PLUGINS =====
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
