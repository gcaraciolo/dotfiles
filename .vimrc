set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/PreserveNoEOL'
Plugin 'terryma/vim-multiple-cursors'

call vundle#end()
filetype plugin indent on

" remaps

nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

nnoremap K <C-u> " move down fast
nnoremap J <C-d> " move up fast
nnoremap H ^ " move left fast
nnoremap L $ " move right fast

" settings

set number
set ruler
set hlsearch
set tabstop=3
set shiftwidth=3
set laststatus=2
set virtualedit=onemore " keep cursor after letter
set visualbell " disable beep sound

syntax on

" ESLint
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

" NERDTree
map <C-a> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close nerd tree when last window is closed

" vim-multiple-cursors

let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_key='<C-d>'
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-s>'
let g:multi_cursor_quit_key='<Esc>'
