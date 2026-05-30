" --- Appearance & UI ---
syntax on            " Enable syntax highlighting
set number           " Show line numbers
set laststatus=2     " Always show the status bar
set wildmenu         " Visual autocomplete for command menu
set showmatch        " Highlight matching brackets

" --- Indentation ---
set tabstop=4        " Number of visual spaces per TAB
set softtabstop=4    " Number of spaces in tab when editing
set shiftwidth=4     " Number of spaces to use for auto-indent
set expandtab        " Convert tabs to spaces
set autoindent       " Copy indent from current line to next

" --- Searching ---
set incsearch        " Search as characters are entered
set hlsearch         " Highlight search results
set ignorecase       " Ignore case when searching
set smartcase        " Override 'ignorecase' if search has uppercase
set path+=.,** 

" --- General Settings ---
set mouse=a          " Enable mouse support in all modes
set clipboard=unnamedplus " Use system clipboard (requires +clipboard support)
set noswapfile       " Disable swap files for cleaner directories
set undolevels=1000  " Increase undo history
set nobackup
set nowritebackup
set ttyfast

" --- file explorer ---
let g:netrw_banner = 0       " Hide the help banner at the top
let g:netrw_liststyle = 3    " Use tree view by default
highlight CursorLine gui=NONE cterm=NONE ctermbg=236

" --- custom keybindings ---
" use colons interchangably
nnoremap ; :

" select current line
nnoremap x V

" Map Space-f to open file explorer
nnoremap <Space>f :Ex<CR>
