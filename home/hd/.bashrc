alias dot='sudo /usr/bin/git --git-dir=/.dot/ --work-tree=/'
alias ls='ls --color -F --group-directories-first'
alias ll='ls -lh'
alias la='ls -lAh'
alias l1='ls -1'
alias vim='nvim -u NONE -N'
alias em='emacsclient -t --alternate-editor='''

PS1='\[\e]0;\w\a\]\[\e[32m\]\w\[\e[m\] \[\e[34m\]>\[\e[m\] '

HISTSIZE=100000
shopt -s histappend

source ~/.local/z.sh
source ~/.local/nnn_quitcd.sh
source /usr/share/doc/fzf/completion.bash
source /usr/share/doc/fzf/key-bindings.bash
