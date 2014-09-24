" @Author: Jose Vidal
" @Version: 1.0.3
" @Last Update: 8/8/2013

" 0.- Run Vundler.
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set tags=./tags;/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'tomtom/tcomment_vim'
Plugin 'sjl/gundo.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'jaxbot/brolink.vim.git'
Plugin 'morhetz/gruvbox'
Plugin 'zeis/vim-kolor'
Plugin 'Chiel92/vim-autoformat'
Plugin 'mattn/emmet-vim'
Plugin 'suxpert/vimcaps'
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on

" 1.- Set Theme.
let &t_Co=256
syntax enable
colorscheme molokai
set guifont=Inconsolata\ 12

" 2.- Set Filetypes.
syntax on

" 3.- VIM's General Configuration.
set number
set history=1000
set showmode
set autoread
set hidden
set nobackup
set noswapfile
set visualbell
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set mouse=a
set pastetoggle=<F3>
set laststatus=2

" 4.- Mapping.
:let mapleader = ","

" Features section
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>m :CtrlPMRU<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPMixed<CR>
nnoremap <leader>d :GundoToggle<CR>
nnoremap <leader>g :Gblame<CR>
nnoremap <leader>x :q!<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>c :tag
nnoremap nn :w<CR>
nnoremap ;q :q
nnoremap :Q :q
nnoremap ;w :w
nnoremap :W :w
nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>
nnoremap <C-z> :q<CR>
nnoremap <F5> :bp<CR>
nnoremap <F6> :bn<CR>
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>
nnoremap <F2> :SyntasticCheck<CR>
nnoremap <F9> :GundoToggle<CR>
cnoremap w!! w !sudo tee % >/dev/null
inoremap jj <esc>

" Navigation section
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remove navigation keys.
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" 5.- Abbreviations.
iabbrev adn and

" 6.- Specific Plugin's Configuration.

au InsertLeave * write

set makeprg=jslint\ %
set errorformat=%-P%f,
        \%E%>\ #%n\ %m,%Z%.%#Line\ %l\\,\ Pos\ %c,
        \%-G%f\ is\ OK.,%-Q

""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""

function! LoadUltisnips()
  if has("python")
    runtime bundle/ultisnips_rep/plugin/UltiSnips.vim
    exec "set runtimepath+=" . g:p0 . "/bundle/ultisnips_rep"
    if has("autocmd")
      autocmd FileType * call UltiSnips_FileTypeChanged()
      autocmd BufNewFile,BufRead *.snippets setf snippets
    endif
    call UltiSnips_FileTypeChanged()
  endif
  nnoremap <f10> :call UltiSnips_ListSnippets()<cr>
endfunction
nnoremap <f10> :call LoadUltisnips()<cr>:call UltiSnips_ListSnippets()<CR>
inoremap <f10> <esc>:call LoadUltisnips()<cr>a<c-r>=UltiSnips_ExpandSnippet()<cr>

let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""
let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline_powerline_fonts   = 1
