set autoindent
set rnu nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set si
syntax enable

set nocompatible              " be iMproved, required
filetype off		              " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'morhetz/gruvbox'
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required

:set t_Co=256
" Colorscheme
colorscheme gruvbox
let g:gruv_box_contrast_dark='hard'
set bg=dark
" make background invisible
hi Normal guibg=NONE ctermbg=NONE


" Snippet setup
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/bundle/vim-snippets/UltiSnips']

"Opening NerdTRee
nmap <C-n> :NERDTreeToggle<CR>
" Close NerdTree after opening selected file
let NERDTreeQuitOnOpen=1


inoremap {<CR> {<CR>}<ESC>O<TAB>

" Moving file through files in buffer
nnoremap NN :bnext<CR>
nnoremap PP :bprev<CR>

" Scrolling
nnoremap MM zz
nnoremap mm MM

" Moving through vim splitscreen
nnoremap <C-J> <C-W>j<C-W>
nnoremap <C-K> <C-W>k<C-W>
nnoremap <C-H> <C-W>h<C-W>
nnoremap <C-L> <C-W>l<C-W>

" Moving through tabs
nnoremap <C-Left> :tabp<CR><CR>
nnoremap <C-Right> :tabn<CR><CR>
