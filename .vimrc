set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable		"enable syntax processing
set encoding=utf-8 "Unicode
set background=dark
if has('gui_running')
    colorscheme solarized
    set guifont="Inconsolata 11"
    set guioptions+=b "Bottom scroll bar
endif
set laststatus=2    "Always show status line

set ruler "Always show current position
set nobackup "No backup file
set tabstop=4		"number of visual spaces per tab
set shiftwidth=4    "shift 4 spaces
set softtabstop=4	"number of spaces in tab when editing
set expandtab		"turn tabs into spaces

set number		"Show line numbers
"set showcmd		"Show command in bottom bar
set cursorline		"Highlight current line
filetype indent on	"load filetype-specific indent files
set wildmenu		"visual autocomplete for command menu
set lazyredraw		"redraw only when we need to
set showmatch		"Highlight matching brackets/parens
set incsearch		"search as characters are entered
set hlsearch		"Highlight search matches
set ignorecase      "Ignore case when searching
set smartcase " ...except if there's capitals

set colorcolumn=120 "Set color column to know when line is too long

"set foldenable		"enable folding
"set foldlevelstart=10	"open most folds by default
"set foldnestmax=10	"10 nested fold max
"nnoremap <space> za	"space opens/closes folds
"set foldmethod=indent	"fold based on indent level

set nowrap		    "Do not wrap lines
set hidden          "Edit multiple files without saving
set history=1000    "remember the last 1000 commands
set ve=all          "Edit anywhere
set autoindent      "Copy indent from current line when starting a new line
set smartindent     "Contex aware indenting
set mouse=a         "Allow mouse use for all modes

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

set viminfo^=% " Remember info about open buffers on close

"NERDTree configurations
"Show hidden files
let NERDTreeShowHidden=1

"Airline configurations
let g:airline_powerline_fonts=0
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"Custom keybindings
let mapleader=","
let g:mapleader = ","

"Move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Move between buffers
nnoremap <silent> H :bp<CR>
nnoremap <silent> L :bn<CR>

"Move through tabs
map <leader>l gt
map <leader>h gT

"turn off search match highlighting until next search
nnoremap <silent> \ :noh<CR>

"Toggle NerdTree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

"Make move to mark move to the correct column, too
nnoremap ' `

"Switch current working directory to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"Toggle between last used buffer
map <silent> <Tab> :b#<cr>
