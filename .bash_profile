if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export PATH=/usr/bin/:/usr/local/bin:/usr/local/share:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
