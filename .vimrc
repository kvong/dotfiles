set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set si
set rnu nu
set noshowmode
syn on
set mouse=a

set guifont=Monaco:h20

filetype plugin on

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
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'lervag/vimtex'
Plugin 'vimwiki/vimwiki'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Config for vimwiki
"let g:vimwiki_list = [{'path': '~/vimwiki',
                        \ 'syntax': 'markdown', 'ext': '.md'}]

" Config for LaTex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" Add plugins before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Snippet setup
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/bundle/vim-snippets/UltiSnips']

:set t_Co=256

" Colorscheme
colorscheme gruvbox
let g:gruv_box_contrast_dark='hard'
set bg=dark

" make background invisible
hi Normal guibg=NONE ctermbg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" Scrolling
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap MM zz
nnoremap mm MM
 
""""""""""""""""""""""""""""""""""""""""""""""""""
" NertTRee
""""""""""""""""""""""""""""""""""""""""""""""""""
"Opening NerdTRee
nmap <C-n> :NERDTreeToggle<CR>
" Close NerdTree after opening selected file
let NERDTreeQuitOnOpen=1

" Close all and save
noremap ZZ :wqa<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Splitting
""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving through Vim splitscreen
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Make new split below or to the right
set splitbelow splitright

""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Tabbing
""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving through Vim tabs
nnoremap PP :tabp<CR>
nnoremap NN :tabn<CR>

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

set foldmethod=marker
set foldmarker=[START],[END]
" TO RELOAD ':so %'
