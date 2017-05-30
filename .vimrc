"=================================
" カスタマイズメモ
"=================================
"---------------------------------
" autocmd
"---------------------------------
" # 概要
" VIMを起動したときに自動的にコマンドを実行する
"
" # コマンド
" autocmd [group] x filetype [nested] command


"---------------------------------
" カラー設定
"---------------------------------
syntax on
set t_Co=256
colorscheme molokai

"---------------------------------
" 基本設定
"---------------------------------
" Vi互換をオフ
set nocompatible
" テキストの自動折り返しなし
set textwidth=0
" バックアップを無効
set nobackup
" 作業中ファイルが書き換えられたら自動で読み直す
set autoread
" スワップファイルを無効
set noswapfile
" ビープ音を鳴らさない
set vb t_vb=
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 現在のモードを表示
set showmode
" omni補完を有効
setlocal omnifunc=syntaxcomplete#Complete
" Ctrl+Fでomni補完
imap <Nul> <C-x><C-o>
" クリップボードを利用する
set clipboard+=unnamed

" バックスペースを有効にする
set backspace=indent,eol,start

"---------------------------------
" ステータスライン
"---------------------------------
" ステータスラインの表示数
set laststatus=2
" ステータスラインの表示情報↲
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%{&fenc!=''?&fenc:&enc}]\ [%p%%]\ line:%l/%L\ col:%v

"---------------------------------
" 表示
"---------------------------------
" 対応する括弧を表示する
set showmatch
" 行番号を表示する
set number
" 不可視文字を表示する
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
" カーソル行のカラーを設定
set cursorline
" 行を折り返して表示しない
set nowrap

"---------------------------------
" インデント
"---------------------------------
" 自動でインデント
set autoindent
" 新しい行のインデントを現在行と同じにする
set smartindent
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2

"---------------------------------
" 検索設定
"---------------------------------
" 検索をファイルの先頭へループする
set nowrapscan
" 検索時に大/小を区別しない
set ignorecase
" 検索時に大文字を含んでいたら大/小を区別する
set smartcase
" インクリメンタルサーチを行う↲
set incsearch
" 検索結果をハイライト
set hlsearch
"Escの2回押しでハイライト消去
nnoremap <silent><ESC><ESC> :nohlsearch<CR><ESC>

"---------------------------------
" キーマッピング
"---------------------------------
" カーソルキーに手が触れて、カーソルがあらぬところに移動して辛かったので無効化
nnoremap  <Up>     <nop>
nnoremap  <Down>   <nop>
nnoremap  <Left>   <nop>
nnoremap  <Right>  <nop>

"---------------------------------
" エンコーディング関連
"---------------------------------
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc
    if s:fileencodings_default =~ 'utf-8'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      let &fileencodings = substitute(&fileencodings, "utf-8", "utf-8,cp932", "g")
    else
      let &fileencodings = &fileencodings .',cp932,'. s:fileencodings_default
    endif
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings.','. s:enc_jis
    set fileencodings += utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings += cp932
      set fileencodings -= euc-jp
      set fileencodings -= euc-jisx0213
      set fileencodings -= eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings.','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"---------------------------------
" ファイルタイプ設定
"---------------------------------
" Gemfile
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
" Berkshelf
autocmd BufNewFile,BufRead Berksfile set filetype=ruby
" CoffeeScript
autocmd BufNewFile,BufRead *.coffee set filetype=coffee

"---------------------------------
" 編集関連
"---------------------------------
"タブをスペースに変換
set expandtab

