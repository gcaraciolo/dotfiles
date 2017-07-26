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

call vundle#end()
filetype plugin indent on

" disable arrow keys usage
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap K <C-u> " move down fast
nnoremap J <C-d> " move up fast

set number
set ruler
set hlsearch
set tabstop=3
set shiftwidth=3
set laststatus=2

syntax on

" ESLint
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

" NERDTree
map <C-a> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close nerd tree when last window is closed
