#----------
# Language
#----------
export LANG=ja_JP.UTF-8

#---------
# History
#---------
# 履歴の保存先ファイル
HISTFILE=$HOME/.zsh_history
# 記憶するコマンド数
HISTSIZE=100000
# ターミナルを閉じても残るコマンド数
SAVEHIST=100000

#------------
# Complement
#------------
# # 概要
# いろいろなコマンドのオプション、引数を保管する
#
# # コマンドの説明
# autoload [option] [function]: シェル関数を読み込む
#          -U                 : 関数内部の alias を展開しない
#
autoload -U compinit
compinit

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#-------------------
# Coredump Settings
#-------------------
# # 概要
# プログラムが異常終了したときに、メモリとレジスタの内容がコアファイルにダンプされる
#
# コアダンプサイズを制限
limit coredumpsize 102400

#--------
# Editor
#--------
# デフォルトエディタ
export EDITOR=/usr/local/bin/vim

#---------------
# Shell options
#---------------
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

#--------------------------
# 単語として認識される文字
#--------------------------
# Ctrl+w でパス文字列を/ごとに削除できるようにする
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#-------------
# Disable key
#-------------
# r コマンド（履歴実行）を無効化
# rails コマンドのミスタイプで実行してしまって邪魔になることが多かったため
disable r

#------------------------
# ユーザ定義のエイリアス
#------------------------
alias vi='vim'
alias g='git'
# bundler 関係のエイリアス
alias be='bundle exec'
alias bi='bundle install --without production --path vendor/bundle'
# JAVA で UTF-8 を利用
alias javac='javac -encoding utf-8'
alias java='java -Dfile.encoding=utf-8'
# Chef/knife 関係のエイリアス
alias k='knife'
alias ks='knife solo'
alias kc='knife cookbook'
alias kn='knife node'

#----------
# Key bind
#----------
# bindkey [option] : キーバインドを設定する
#         -e       : Emacs
#         -v       : VIM
#
bindkey -e

# Ctrl+R の検索でAND検索できるようにする
bindkey '^R' history-incremental-pattern-search-backward

#-------
# Path
#-------
# El Capitan用
export PATH=/usr/local/bin:$PATH
# アーキテクチュアに依存したデータを置くディレクトリ
export PATH=/usr/local/share:$PATH

#-----
# Git
#-----
export PATH=/usr/local/opt/git/share/git-core/contrib/diff-highlight:$PATH
export PATH=/usr/local/opt/git/share/git-core/contrib/git-jump:$PATH

#-----------------
# Heroku Toolbelt
#-----------------
export PATH="/usr/local/heroku/bin:$PATH"

#-------
# rbenv
#-------
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

#--------
# direnv
#--------
eval "$(direnv hook zsh)"

#----------
# nodebrew
#----------
export PATH=$HOME/.nodebrew/current/bin:$PATH

#----------
# Embulk
#----------
export PATH="$HOME/.embulk/bin:$PATH"

#-------------
# Show branch
#-------------
# # 概要
# プロンプトにブランチ名を表示する
#
# # zstyle のフォーマットの説明
# %b : ブランチ名
# %a : アクション名（merge とか）
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

#--------
# Prompt
#--------
# $B        : 太字
# %F{color} : カラーリング
# %n        : ホスト名
# %m        : マシン名
# %.        : ディレクトリ名
# %*        : 時刻(mm:nn:ss)
# $'\n'     : 改行
# %(a,b,c)  : 三項演算子 a ? b : c
#
PROMPT="%B%(?,%F{083},%F{205})[%n@%m: %.]%f%b %1(v,%B%F{045}%1v%f%b,)
%B%(!,#,$)%b "
