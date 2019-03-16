set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set si
set rnu nu
syn on

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'

" Add plugins before the following line
call vundle#end()            " required
filetype plugin indent on    " required

:set t_Co=256

" Colorscheme
colorscheme gruvbox
let g:gruv_box_contrast_dark='hard'
set bg=dark

" make background invisible
hi Normal guibg=NONE ctermbg=NONE

" VIM powerline
set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2

" VIM shortcuts
nnoremap NN :bnext<CR> 
nnoremap PP :bprev<CR>
