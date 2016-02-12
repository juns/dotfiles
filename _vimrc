" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END
"----------------------------------------
" NeoBundle
"----------------------------------------
" pluginを使用可能にする
"filetype plugin indent on
set nocompatible
filetype off            " for vundle

if has("vim_starting")
set rtp+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))
endif

" NeoBundle
let g:neobundle_default_git_protocol='https'

" NeoBundle自身をNeoBundleで管理させる
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-ref'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'justinmk/vim-dirvish'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'airblade/vim-gitgutter'
call neobundle#end()

filetype plugin indent on     " required!
NeoBundleCheck

filetype indent on
syntax on

set grepprg=C:/cygwin64/bin/grep\ -nH
let $CYGWIN = 'nodosfilewarning'
"set grepprg=internal

set undodir=c:/home/var/vim/undo

"--------------------------------------------
"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
"nmap    <Leader>f [unite]
"nmap    <Space>u [unite]
nmap    , [unite]
 
" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]w :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> [unite]r :UniteResume<CR>
nnoremap <silent> [unite]v :NERDTreeToggle<CR>
 
" vinarise
let g:vinarise_enable_auto_detect = 1
 
" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
"" }}}

let g:unite_source_grep_command = 'C:/cygwin64/bin/grep'

" vim-indent-guides
"let g:indent_guides_auto_colors=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

"--------------------------------------------
"" vimfiler
"let g:vimfiler_as_default_explorer = 1
"let g:vimfiler_safe_mode_by_default = 0
"nnoremap <silent> [unite]v :VimFiler -split -simple -winwidth=45 -no-quit<ENTER>


"--------------------------------------------
"" vim-lightline {{{
set laststatus=2
set background=dark
let g:lightline = {
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"" }}}

"--------------------------------------------
"" tabline {{{
set showtabline=2 " 常にタブラインを表示
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
"}}}


" 不可視文字を表示する
set list
"set listchars=eol:$,tab:>\ 
set listchars=tab:>\ 

set nowritebackup
set nobackup
set noswapfile

set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" 行番号の表示
set number

" tab設定
set tabstop=4
set cino=+4,g0,(0
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
"set nolist
" スクロールバーを無しに
set guioptions=maF
" カーソルがあるテキストの周りを見やすく
set so=5
" タブをスペースに変換
set expandtab
" 検索の時に大文字小文字を区別しない
" ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" インクリメンタルサーチ
set incsearch
" 検索文字の強調表示
set hlsearch

set clipboard+=unnamed
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden
" ヒストリの保存数
set history=50
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" Visual blockモードでフリーカーソルを有効にする
set virtualedit=block
" カーソルキーで行末／行頭の移動可能に設定
"set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu

"---------------------------------------------------------------------------
" プログラミング設定:
"---------------------------------------------------------------------------
set shiftwidth=4
set smartindent
set ar
set tw=0


"----------------------------------------
" [plugin] qfix*
"----------------------------------------
let mygrepprg = 'c:/cygwin64/bin/grep'
let MyGrep_cygwin17 = 1
" キーマップリーダー
let QFixHowm_Key = 'g'

" howm_dirはファイルを保存したいディレクトリを設定
let howm_dir             = 'c:/home/howm'
let howm_fileencoding    = 'cp932'
let howm_fileformat      = 'dos'
let QFixHowm_FileType = 'qfix_memo'

"" qfixhowm {{{
" ファイル拡張子をmdにする
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
" ファイルタイプをmarkdownにする
"
"let QFixHowm_FileType = 'markdown'
" タイトル記号
"let QFixHowm_Title = '#'
" タイトル行検索正規表現の辞書を初期化
"let QFixMRU_Title = {}
" MRUでタイトル行とみなす正規表現(Vimの正規表現で指定)
"let QFixMRU_Title['mkd'] = '^###[^#]'
" grepでタイトル行とみなす正規表現(使用するgrepによっては変更する必要があります)
"let QFixMRU_Title['mkd_regxp'] = '^###[^#]'
" }}}

",yでの予定表示期間
let QFixHowm_ShowSchedule     = 10
",tでの予定表示期間
let QFixHowm_ShowScheduleTodo = -1
",,での予定表示期間
let QFixHowm_ShowScheduleMenu = 10
",y で表示される予定・TODOパターン
let QFixHowm_ListReminder_ScheExt = '[@!.]'
",t で表示される予定・TODOパターン
let QFixHowm_ListReminder_TodoExt = '[-@+!~.]'
",, で表示される予定・TODOパターン
let QFixHowm_ListReminder_MenuExt = '[-@+!~.]'

"----------------------------------------
" [plugin] スクラッチバッファ
"----------------------------------------
let g:scratchBackupFile=$HOME . "/scratch.txt"

set textwidth=0

"-----------------------------------------
" キー マクロ関係
"-----------------------------------------

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif
