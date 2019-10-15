set autoindent
set rnu nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
syn on

set nocompatible              " be iMproved, required
filetype off	                  " required

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

" Close all and save
nnoremap ZZ :wqa


inoremap {<CR> {<CR>}<ESC>O<TAB>

" Moving file through files in buffer
"nnoremap NN :bnext<CR>
"nnoremap PP :bprev<CR>

" Scrolling
nnoremap MM zz
nnoremap mm MM

" Moving through vim splitscreen
nnoremap <C-J> <C-W>j<C-W><CR>
nnoremap <C-K> <C-W>k<C-W><CR>
nnoremap <C-H> <C-W>h<C-W><CR>
nnoremap <C-L> <C-W>l<C-W><CR>

" Moving through tabs
nnoremap NN :tabn<CR>
nnoremap PP :tabp<CR>
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
