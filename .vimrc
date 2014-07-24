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
nmap <silent><ESC><ESC> :nohlsearch<CR><ESC>

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
" Ruby ファイルタイプ設定
"---------------------------------
" Guard
autocmd BufNewFile,BufRead Guardfile set filetype=ruby
" Berkshelf
autocmd BufNewFile,BufRead Berksfile set filetype=ruby

"---------------------------------
" 編集関連
"---------------------------------
"タブをスペースに変換
set expandtab

"---------------------------------
" プラグイン設定
"---------------------------------

"---------------------------------
" NeoBundle
"---------------------------------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'basyura/unite-rails'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jpalardy/vim-slime'

"---------------------------------
" syntasic.vim
"---------------------------------
" ruby のファイルを保存したときに rubocop を動かす
NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"---------------------------------
" vim-tags
"---------------------------------
NeoBundle 'szw/vim-tags'
let g:vim_tags_project_tags_command = "/usr/local/Cellar/ctags/5.8/bin/ctags -f tags -R . 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/Cellar/ctags/5.8/bin/ctags -R -f Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
set tags+=tags,Gemfile.lock.tags

"---------------------------------
" neocomplcache.vim
"---------------------------------
NeoBundle 'Shougo/neocomplcache'
"let g:neocomplcache_enable_at_startup = 1

"---------------------------------
" NERDTree.vim
"---------------------------------
NeoBundle 'scrooloose/nerdtree'
" 作業ウィンドウにカーソルを合わせる
"  autocmd vimenter * if argc() | NERDTree | wincmd p | endif
" 最後のウィンドウを閉じたときにNERDTreeも閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 隠しファイルを表示するか
let NERDTreeShowHidden=1
" 表示しないファイル
let NERDTreeIgnore=['\.git$', '\.DS_Store', '\~$']

"---------------------------------
" Plugin After setting
"---------------------------------
filetype plugin indent on
filetype indent on
syntax on
