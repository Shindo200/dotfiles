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
export EDITOR=/usr/bin/vim

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

#-------------
# Disable key
#-------------
# r コマンド（履歴実行）を無効化
disable r

#-----------------------
# User specific aliases
#-----------------------
alias vi='vim'
alias g='git'
alias irb='pry'
alias be='bundle exec'
alias r='rails'
# JAVA で UTF-8 を利用
alias javac='javac -encoding utf-8'
alias java='java -Dfile.encoding=utf-8'
# Node.js で ECMAScript6 の構文(yield とか)を利用
alias node='node --harmony'
# 全ディレクトリの .DS_STORE を削除
alias rmds="find . -name \".DS_Store\" -exec rm -f {} \;"
# USB でバイスを表示する
alias lsusb='system_profiler SPUSBDataType'

#----------
# Key bind
#----------
# # 概要
# Vim は素晴らしい.
# でも、シェルの操作は Emacs のキーバインドのが素敵だった.
#
# # コマンドの説明
# bindkey [option] : キーバインドを設定する
#         -e       : Emacs
#         -v       : VIM
#
bindkey -e

#-------
# Path
#-------
# アーキテクチュアに依存したデータを置くディレクトリ
export PATH=/usr/local/share:$PATH

#-----------------
# Heroku Toolbelt
#-----------------
export PATH="/usr/local/heroku/bin:$PATH"

#-------
# rbenv
#-------
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#--------
# PHP5.5
#--------
export PATH=/usr/local/php5/bin:$PATH

#----------
# nodebrew
#----------
export PATH=$HOME/.nodebrew/current/bin:$PATH

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
RPROMPT="%B%F{220}<%*>%f%b"
