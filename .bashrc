# .bashrc

# User specific aliases and functions

PS1='[\u@\h \W]\$ '

alias deldsfile="find . -name \".DS_Store\" -exec rm -f {} \;"
alias vi='vim'
alias v='vim'
alias g='git'
alias r='rails'
alias irb='pry'
alias javac='javac -encoding utf-8'
alias java='java -Dfile.encoding=utf-8'
alias lsusb='system_profiler SPUSBDataType'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
