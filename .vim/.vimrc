" @Author: Jose Vidal
" @Version: 1.0.3
" @Last Update: 8/8/2013

" 1.- Plugins ############################################
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set tags=./tags;/
call vundle#begin()

Plugin 'gmarik/Vundle.vim' "Plugins loader
Plugin 'tpope/vim-fugitive' "Git wrapper
Plugin 'kien/ctrlp.vim' "Multi-search tool for MRU files, buffer...
Plugin 'scrooloose/nerdtree' "Provides vertical files search tree
Plugin 'scrooloose/syntastic' "Multi-language validator (PEPE8...)
Plugin 'tpope/vim-surround' "Adds/Removes quotes/parenthesis easily
Plugin 'Raimondi/delimitMate' "Adds ending quotes/parenthesis automatically
Plugin 'tomtom/tcomment_vim' "Comments out lines easily
Plugin 'sjl/gundo.vim' "Shows last changes in a file
Plugin 'SirVer/ultisnips' "Snippets loader
Plugin 'honza/vim-snippets' "Collection of snippets
Plugin 'xolox/vim-misc' "Library of functions
"Plugin 'xolox/vim-easytags' "Provides search by tags functionality
"Plugin 'jaxbot/brolink.vim.git' "Live browser editing in VIM
Plugin 'Chiel92/vim-autoformat' "Auto-format for different languages
Plugin 'mattn/emmet-vim' "Zen style abbreviations in HTML
"Plugin 'suxpert/vimcaps' "Disables caps in Insert Mode (It has some problems
"when it's used in a remote machine, that's why it's disabled by default)
Plugin 'bling/vim-airline' "Provides a bottom bar with useful data
Plugin 'Yggdroot/indentLine' "Adds visual indentation lines
Plugin 'terryma/vim-multiple-cursors' "Adds multiple cursor support (like in Sublime Text)
"Plugin 'airblade/vim-gitgutter' "Adds signs whether a certain line has been modified or not
Plugin 'Shougo/vimproc.vim' "Utility methods required for Vimshell
Plugin 'Shougo/vimshell.vim' "Includes a shell into VIM
Plugin 'fatih/vim-go' "Add golang support
Plugin 'ervandew/supertab' "Add supertab
Plugin 'benmills/vimux' "Add small pane where you can run cmds
Plugin 'tpope/vim-obsession' "Save vim sessions automatically
Plugin 'morhetz/gruvbox' "Incredible theme

call vundle#end()
filetype plugin indent on

" 1.- Set Theme.
let &t_Co=256
syntax enable
colorscheme gruvbox
set guifont=Inconsolata\ 12
set background=dark

syntax on "Enable syntax highlighting

set number "Show number line
set history=1000 "Increase commands history
set showmode "Show current mode in the bar
set autoread "Reload files as soon as they change in disk
set hidden "Hide previous buffer instead than prompt the user
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
set ttyfast "Allows smooth scrolling (No more delays)

" 3.- Mappings ###########################################
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
nnoremap <leader>p :VimShellInteractive python<CR>
nnoremap <leader>j :VimShellInteractive node<CR>
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
nnoremap mm :
cnoremap w!! w !sudo tee % >/dev/null
inoremap jj <esc>
inoremap jjj <esc>:q<CR>

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

" 4.- Abbreviations #####################################
iabbrev adn and

" 5.- Specific Plugin's Configuration ###################

"au InsertLeave * write "Saves the file after leaving the 'Insert' mode.

set makeprg=jslint\ %
set errorformat=%-P%f,
        \%E%>\ #%n\ %m,%Z%.%#Line\ %l\\,\ Pos\ %c,
        \%-G%f\ is\ OK.,%-Q

""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>""

""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""
let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline_powerline_fonts   = 1

""""""""""""""""""""""""""""""
" indentLIne
""""""""""""""""""""""""""""""
let g:indentLine_color_term = 239

" VIMUX

 " Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

 " Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

 " Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

 " Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

 " Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

 " Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>
