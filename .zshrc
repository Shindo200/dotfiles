# Save Histories
export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Load autocomp
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# コアダンプサイズを制限
limit coredumpsize 102400

# Set default editor
export EDITOR=/usr/bin/vim

# Set shell options
unsetopt promptcr
setopt prompt_subst
setopt nobeep
setopt long_list_jobs
setopt list_types
setopt auto_resume
setopt auto_list
setopt hist_ignore_dups
setopt autopushd
setopt pushd_ignore_dups
setopt extended_glob
setopt auto_menu
setopt extended_history
setopt equals
setopt magic_equal_subst
setopt share_history
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash

PROMPT='%F{green}[%n@%m %.]%f$ '

# User specific aliases and functions
alias deldsfile="find . -name \".DS_Store\" -exec rm -f {} \;"
alias vi='vim'
alias v='vim'
alias g='git'
alias irb='pry'
alias javac='javac -encoding utf-8'
alias java='java -Dfile.encoding=utf-8'
alias lsusb='system_profiler SPUSBDataType'
alias bundle='bundler-first_commit'
alias node='node --harmony'

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Added by the rbenv and setup
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Added by the PHP5.5
export PATH=/usr/local/php5/bin:$PATH

# Added nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
