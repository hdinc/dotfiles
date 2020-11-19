export PATH=$PATH:$HOME/Software/local/bin/
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.local/Android/cmdline-tools/tools/bin/

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Software/local/lib/:$HOME/Software/local/lib64/

export EDITOR='nvim'
export TERMINAL='st'
export BROWSER='firefox'
export READER='zathura'
export OPENER='mimeopen'

export ANDROID_HOME=$HOME/.local/Android
export MPD_HOST=$HOME/.config/mpd/mpd.socket
export FZF_DEFAULT_COMMAND='fd --type f --follow'
export FZF_DEFAULT_OPTS='--color bw'

export PS1='\[\e]0;\w\a\]\[\e[32m\]\w\[\e[m\] \[\e[34m\]>\[\e[m\] '

source ~/.local/less_colors.sh
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || 
    eval $(dircolors -b)

source ~/.bashrc
