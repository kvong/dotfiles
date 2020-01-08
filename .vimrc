set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set si
set rnu nu
set noshowmode
syn on

set guifont=Monaco:h20

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
Plugin 'lervag/vimtex'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ervandew/supertab'

" Add plugins before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['C-n', '<Down>']
"let g:ycm_key_list_previous_completion = ['C-p', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" LaTex setup
let g:tex_flavor='latex'
let g:vimtext_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

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

" VIM powerline
" set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
" set laststatus=2


" VIM shortcuts
 
" Moving through files in buffer
"nnoremap NN :bnext<CR> 
"nnoremap PP :bprev<CR>

" Scrolling
"nnoremap J <C-E>
"nnoremap K <C-Y>
nnoremap MM zz
nnoremap mm MM

"Opening NerdTRee
nmap <C-n> :NERDTreeToggle<CR>
" Close NerdTree after opening selected file
let NERDTreeQuitOnOpen=1

" Close all and save
 noremap ZZ :wqa<CR>


" Moving through Vim splitscreen
nnoremap <C-J> <C-W>j<C-W><CR>
nnoremap <C-K> <C-W>k<C-W><CR>
nnoremap <C-H> <C-W>h<C-W><CR>
nnoremap <C-L> <C-W>l<C-W><CR>

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
" TO RELOAD ':so %'
