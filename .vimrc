set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'triglav/vim-visual-increment'
Plug 'tommcdo/vim-lion'
Plug 'aklt/plantuml-syntax'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
"Plug 'dense-analysis/ale'

" All of your Plugins must be added before the following line
call plug#end()            " required

set encoding=utf-8 "Unicode
set background=dark
if has('gui_running')
    colorscheme solarized
    set guifont=Consolas:h11:cANSI:qDRAFT
    set guioptions+=b "Bottom scroll bar
else
    set termguicolors
    colorscheme desert
endif
set laststatus=2    "Always show status line

set ruler "Always show current position
set nobackup "No backup file
set tabstop=2           "number of visual spaces per tab
set shiftwidth=2    "shift 4 spaces
set softtabstop=2       "number of spaces in tab when editing
set expandtab           "turn tabs into spaces

set number              "Show line numbers
"set showcmd            "Show command in bottom bar
set cursorline          "Highlight current line
filetype indent on      "load filetype-specific indent files
set wildmenu            "visual autocomplete for command menu
set lazyredraw          "redraw only when we need to
set showmatch           "Highlight matching brackets/parens
set incsearch           "search as characters are entered
set hlsearch            "Highlight search matches
set ignorecase      "Ignore case when searching
set smartcase " ...except if there's capitals
set undofile "Persist undo across vim instances by writing undo tree to a file

"set colorcolumn=120 "Set color column to know when line is too long

"set foldenable         "enable folding
"set foldlevelstart=10  "open most folds by default
"set foldnestmax=10     "10 nested fold max
"nnoremap <space> za    "space opens/closes folds
"set foldmethod=indent  "fold based on indent level

set nowrap                  "Do not wrap lines
set hidden          "Edit multiple files without saving
set history=1000    "remember the last 1000 commands
set ve=all          "Edit anywhere
set autoindent      "Copy indent from current line when starting a new line
set cindent
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
"Use ack.vim with ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

"Custom keybindings
let mapleader=","
let g:mapleader = ","

let b:lion_squeeze_spaces = 1

"Move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Move between buffers
nnoremap <silent> H :bp<CR>
nnoremap <silent> L :bn<CR>

"Move through tabs
map <leader>l gt
map <leader>h gT

map <ScrollWheelUp> <C-Y>
map <ScrollWhellDown> <C-E>
nmap <Up> <C-Y>
nmap <Down> <C-E>

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

nmap <silent> <space><space> <cmd>Telescope find_files<cr>
nmap <silent> <space>, <cmd>Telescope buffers<cr>

"Update ctags for pwd
nmap <silent> <leader>t :!ctags -R --languages=vhdl,c,c++,python,matlab .<cr>

nnoremap <silent> <leader>* <cmd>Telescope grep_string<cr>
nnoremap <silent> <space>/ <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>/ <cmd>Telescope live_grep<cr>

nnoremap <silent> gs :vertical G<cr>

nnoremap <silent> <esc><esc><esc> :only<cr>
