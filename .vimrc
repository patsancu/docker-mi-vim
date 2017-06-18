" Keep backup stuff organized
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set encoding=utf-8
set tabstop=4
set number
set cursorline

" Incremental search
set incsearch

set expandtab
set tabstop=4
set shiftwidth=4

set cryptmethod=blowfish2

"Folding
set foldenable
set foldlevel=0
set foldnestmax=1
set foldmethod=indent
set foldtext=FoldText()

function FoldText()
    return '...'
endfunction
"Only very nested blocks are folded
set foldlevelstart=10

" Show trailing whitespaces as errors
match ErrorMsg '\s\+$'

" just to avoid the freaking prompt at launch-time
"set cmdheight=3
" Copy paste to system clipboard
set clipboard=unnamedplus

"Cursor briefly jumps to the matching brace when
"you insert one
set showmatch
set matchtime=3

"Shows end of lines and stuff
":set nolist to disable
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set ignorecase
set smartcase
set backspace=indent,eol,start

iabbr #p #!/usr/bin/python
iabbr #b #!/bin/bash

" ================PLUGINS================
"Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
"https://github.com/junegunn/vim-plugg
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'Valloric/YouCompleteMe'
Plug 'mattn/emmet-vim' " HTML generation
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-exchange'
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Mercurial
Plug 'ludovicchabant/vim-lawrencium'
"
" Initialize plugin system
call plug#end()
" ================PLUGINS END===============
"
color seoul256
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
" -----------------------
" Plugin configuration
" ------------------------



" Airline
" -------
" In order for airline to show always the statusline,
" and not only only splits
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" NERDTree
" ========
"let g:NERDTreeBookmarksFile = $HOME ."/.vim/plugged/nerdtree/bookmarks" " existing path to bookmarg
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeQuitOnOpen = 1
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'


" YouCompleteMe
" ========
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Emmejt
" ========
" Enable Emmet just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Closetag
" ========
" Enable Emmet just for html/css
"vim-closetag only for suitable files
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

" Syntastic
" ========
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Fugitive
" ========
set statusline+=%{fugitive#statusline()}

" -----------------
" Undo configuration
" ------------------
"
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    silent call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Python formatting
" ------------------
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

"--------
"Mappings
"--------
let mapleader=","

"Tmux navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>

"copy paste
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
" Change buffers
nnoremap <Leader>k :bprev<CR>
nnoremap <Leader>l :bnext<CR>
nnoremap <A-j> :m .+1<CR>==

" Highlight words when searching by
" hitting enter
noremap <CR> :set hlsearch! hlsearch?<CR>

" Remove trailing whitespaces
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

nnoremap <Leader>n :NERDTreeToggle<CR>
"Fold toggle
nnoremap <Leader>f zA<CR>

map <Leader>U gUU
map <Leader>u guu

" Print current file's full path
noremap <leader>, :echo expand('%:p')<CR>
noremap <leader>. :set list!<CR>

" Enter space in normal mode with ss
nnoremap ss i<space><esc>

" Enter new line in normal mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Quit buffer with ,q
nnoremap <Leader>q :bd<Enter>

nnoremap <Leader>p :TagbarToggle<CR>
nnoremap <Leader>ev :Eval<CR>

" Relative line number by default,
" enter absolute when
" editing text
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Map caps to escape
au VimEnter :silent * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"Unmap caps to escape
au VimLeave :silent * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Highlight in red with white font
hi Search ctermbg=DarkRed ctermfg=White
"Rounded separators (extra-powerline-symbols):
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
