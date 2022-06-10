alias dot='sudo /usr/bin/git --git-dir=/.dot/ --work-tree=/'
alias ls='ls --color -F --group-directories-first'
alias ll='ls -lh'
alias la='ls -lAh'
alias l1='ls -1'
alias vim='nvim -u NONE -N'
alias em='TERM=xterm-24bits emacsclient -t --alternate-editor='''

alias xi='sudo xbps-install'
alias xq='sudo xbps-query'
alias xrs='sudo xbps-query -Rs'
alias xp='sudo xbps-remove -Rf'
alias xr='sudo xbps-remove'

PS1='\[\e]0;\w\a\]\[\e[32m\]\w\[\e[m\] \[\e[34m\]>\[\e[m\] '

if [[ -n "$PROMPT_PREFIX" ]]; then
    PS1="${PROMPT_PREFIX}${PS1}"
fi

HISTSIZE=100000
shopt -s histappend

source ~/.local/z.sh
source ~/.local/nnn_quitcd.sh
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
