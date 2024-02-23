" Turn on syntax highlighting.
set nocompatible

" ------------------
" syntax and indent
" ------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" highlight current line, but only in active window
augroup cursorlineonlyinactivewindow
    autocmd!
    autocmd vimenter,winenter,bufwinenter * setlocal cursorline
    autocmd winleave * setlocal nocursorline
augroup end
" vim can autodetect this based on $term (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_co=256
if has('gui_running')
    colorscheme solarized
    let g:lightline = {'colorscheme': 'solarized'}
" elseif &t_co < 256
"    colorscheme default
"    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme solarized
    " customized colors
    highlight signcolumn ctermbg=234
    highlight statusline cterm=bold ctermfg=245 ctermbg=235
    highlight statuslinenc cterm=bold ctermfg=245 ctermbg=235
    let g:lightline = {'colorscheme': 'dark'}
    highlight spellbad cterm=underline
    " patches
    highlight cursorlinenr cterm=none
endif

filetype plugin indent on " enable file type detection
set autoindent
"---------------------
" basic editing config
"---------------------

set shortmess+=i " disable the default vim startup message.
set number " show line numbers.
" this enables relative line numbering mode. with both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" this is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber " always show the status line at the bottom, even if you only have one window open.
set laststatus=2
" the backspace key has slightly unintuitive behavior by default. for example,
" by default, you can't backspace before the insertion point set with 'i'.
" this configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start
" by default, vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. this is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. we find
" hidden buffers helpful enough to disable this protection. see `:help hidden`
" for more information on this.
set hidden
" this setting makes search case-insensitive when all characters in the string
" being searched are lowercase. however, the search becomes case-sensitive if
" it contains any capital letters. this makes searching more convenient.

" enable searching as you type, rather than waiting till you press enter.
set ignorecase
set smartcase 
set incsearch " unbind some useless/annoying default key bindings.
nmap q <nop> " 'q' in normal mode enters ex mode. you almost never want this.
" enable mouse support. you should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow 0 inserts
set lazyredraw " skip redrawing screen in some cases
set autochdir " automatically set current directory to directory of last opened file
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tab during formatting
set expandtab 
set tabstop=4
set shiftwidth=4
set softtabstop=4
" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
if &term =~ '^screen'
" tmux knows the extended mouse mode
set ttymouse=xterm2
endif
set nofoldenable " disable folding by default
"--------------------
" misc configurations
"--------------------

set noerrorbells visualbell t_vb= " disable audible bell because it's annoying.

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"mapping leader and local leader
let mapleader = ","
let maplocalleader = "\\"

"directory and use of vim plugin vim-plug
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'jalvesaq/nvim-r'
Plug 'jpalardy/vim-slime'
Plug 'sjl/gundo.vim'
Plug 'https://github.com/jeetsukumaran/vim-buffergator'
Plug 'dense-analysis/ale'
Plug 'https://github.com/mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()


" try to prevent bad habits like using the arrow keys for movement. this is
" not the only possible bad habit. for example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. the former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" do this in normal mode...
nnoremap <left>  :echoe "use h"<cr>
nnoremap <right> :echoe "use l"<cr>
nnoremap <up>    :echoe "use k"<cr>
nnoremap <down>  :echoe "use j"<cr>
" ...and in insert mode
inoremap <left>  <esc>:echoe "use h"<cr>
inoremap <right> <esc>:echoe "use l"<cr>
inoremap <up>    <esc>:echoe "use k"<cr>
inoremap <down>  <esc>:echoe "use j"<cr>

" I should just be more careful, but I hate that this can mess with my code
" without me realizing it, so I'm going to remap the lowercase function to
" require a leader
noremap gu          :echoe "use leader l"<cr> 
noremap <leader>l   gu

"some vimscript practice

noremap <leader>-      0v$y<esc>dd<esc>p
noremap <leader>_      0v$y<esc>dd<esc>kkp
noremap <leader><c-u>  viwu


" I want to make it so I can jump to a place and have it centered rather
" easily
" nnoremap  <space> ggzz

" mapping H and L for more sensible move to start and end of line binds
nnoremap L $
nnoremap H 0
nnoremap U H
nnoremap D L


"making it so i can access vimrc quickly from vim
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr> 
set showcmd
"ctrlp mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'ctrlp'

" for all buffers
let g:slime_target = "tmux"
let g:slime_bracketed_paste = 1


colorscheme desert

"---------------------
" Plugin configuration
"---------------------

" nerdtree nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" buffergator
let g:buffergator_suppress_keymaps = 1
nnoremap <Leader>b :BuffergatorToggle<CR>

" gundo
nnoremap <Leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" ag / ack.vim
command -nargs=+ Gag Gcd | Ack! <args>
nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    let g:ackprg = 'ag --vimgrep'
endif

" ultisnips
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips'] " ultisnips only goes through this file 

" psql?
au BufRead /tmp/psql.edit.* set syntax=sql
