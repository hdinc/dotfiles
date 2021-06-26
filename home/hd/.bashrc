alias dot='sudo /usr/bin/git --git-dir=/.dot/ --work-tree=/'
alias ls='ls --color -F'
alias ll='ls -lh -F'
alias l1='ls -1 -F'
alias vim='nvim -u NONE -N'

PS1='\[\e]0;\w\a\]\[\e[32m\]\w\[\e[m\] \[\e[34m\]>\[\e[m\] '

HISTSIZE=10000

source ~/.local/z.sh
source ~/.local/nnn_quitcd.sh
source /usr/share/doc/fzf/completion.bash
source /usr/share/doc/fzf/key-bindings.bash
