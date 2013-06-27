set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"设置文件的代码形式
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,latin1

"vim的菜单乱码解决
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"vim提示信息乱码的解决
language message zh_CN.utf-8

" 无法打开 xxx 交换文件的解决
:set directory=.,$TEMP

if has("unix") 
    cd ~
elseif has("win32") 
    cd d:\
endif

" start maximized on windows
au GUIEnter * simalt ~x

""""" -- pathogen --
execute pathogen#infect()

syntax enable
syntax on
filetype plugin indent on

"""""  -- mapleader --
"let mapleader = ","

imap <C-s> <esc>:w<cr>
nmap <C-s> <esc>:w<cr>
nmap <f4> :q<cr>

"""""  -- colorscheme --
colorscheme evening

"""""  -- tab --
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set nu
set hlsearch

"""""  -- YouCompleteMe --
"let g:ycm_key_invoke_completion = '<C-w>'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

"""""  -- Syntastic --
"let g:syntastic_check_on_open=1

"""""  -- NERDTree --
nmap <leader>tr :NERDTreeToggle<cr> 
let NERDTreeChDirMode=1
let NERDChristmasTree=1
let NERDTreeShowBookmarks=1
" move tabs to the end for new, single buffers (exclude splits)
autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif
if ! &diff && has("gui_running")
    autocmd vimenter * NERDTree 
    autocmd VimEnter * wincmd w
endif

"""""  -- copy and paste --
vmap <A-c> "+y
nmap <A-v> "+p
vmap <A-v> "+p
imap <A-v> <esc>"+p

"""""  -- PowerLine --
set nocompatible
set laststatus=2
let g:Powerline_stl_path_style = 'relative'
let g:Powerline_colorscheme = 'solarized256'

"""""  -- Tagbar --
nmap <leader>tt :TagbarToggle<cr>
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-TAB> <C-W>w

"""""  -- voom --
nmap <leader>v :VoomToggle<cr>
let g:voom_tree_placement = "right"

nmap [1 <esc>$a{{{1<esc>
nmap [2 <esc>$a{{{2<esc>
nmap [3 <esc>$a{{{3<esc>
nmap [4 <esc>$a{{{4<esc>
nmap [5 <esc>$a{{{5<esc>
    
imap [1 <esc>$a{{{1
imap [2 <esc>$a{{{2
imap [3 <esc>$a{{{3
imap [4 <esc>$a{{{4
imap [5 <esc>$a{{{5

"""""  -- bufexplorer --
noremap <silent> <F1> :BufExplorer<CR>
noremap <silent> <leader>be :BufExplorer<CR>

"""""  -- ctrlp --
let g:ctrlp_working_path_mode = 'ra'

"""""  -- snipMate --
"let g:snippets_dir="~/.vim/bundle/snipmate/snippets"
"ino <c-l> <c-r>=TriggerSnippet()<cr>
"snor <c-l> <esc>i<right><c-r>=TriggerSnippet()<cr>

"""""  -- ultisnip --
"let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
"let g:UltiSnipsExpandTrigger="<c-l>"
"let g:UltiSnipsJumpForwardTrigger="<c-l>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""" -- cscope --
" copy from cscope doc: cscope-suggestions
"if has("cscope")
"	set csprg=/usr/local/bin/cscope
"	set csto=0
"	set cst
"	set nocsverb
"	" add any database in current directory
"	if filereadable("cscope.out")
"	    cs add cscope.out
"	" else add database pointed to by environment
"	elseif $CSCOPE_DB != ""
"	    cs add $CSCOPE_DB
"	endif
"	set csverb
"endif

"make cscope result display to quickfix
:set cscopequickfix=s-,c-,d-,i-,t-,e-,g-

" Auto update cscope database
function Updatedb()
    silent exec "!dir /s /b *.h *.c *.cc *.cpp *.hpp > cscope.files"
    silent exec "!cscope -Rb -i cscope.files"
    exec "cs add cscope.out"
endfunction

nmap <c-f5> :call Updatedb()<cr><cr>
nmap <f5> :cs add cscope.out<cr>

:set csprg=d:\programs\Vim\vim73\cscope.exe

" 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-c>s :cs find s <C-R>=expand("<cword>")<CR><CR>:cw<cr>

" 查找函数、宏、枚举等定义的位置
nmap <C-c>g :cs find g <C-R>=expand("<cword>")<CR><CR>:cw<cr>

" 查找调用本函数的函数
nmap <C-c>c :cs find c <C-R>=expand("<cword>")<CR><CR>:cw<cr>

" 查找指定的字符串
nmap <C-c>t :cs find t <C-R>=expand("<cword>")<CR><CR>:cw<cr>

" 查找egrep模式，相当于egrep功能，但查找速度快多了
nmap <C-c>e :cs find e <C-R>=expand("<cword>")<CR><CR>:cw<cr>

" 查找并打开文件，类似vim的find功能
nmap <C-c>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:cw<cr>

" 查找包含本文件的文件
nmap <C-c>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:cw<cr>

" 查找本函数调用的函数
nmap <C-c>d :cs find d <C-R>=expand("<cword>")<CR><CR>:cw<cr>

"""""" quickfix
" toggle quickfix
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
nmap <f2> :QFix<cr>
nmap <a-f2> :colder<cr>
nmap <a-f3> :cnewer<cr>

""""""  auto load txt syntax file
au BufRead,BufNewFile *.txt set filetype=txt
au BufRead,BufNewFile CMakeLists.txt set filetype=cmake
au BufRead,BufNewFile *.cmake  set filetype=cmake
au BufRead,BufNewFile *.cm  set filetype=cmake
