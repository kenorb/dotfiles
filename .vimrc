"####################
"#    Vim config    #
"# Author: kenorb   #
"####################

" Syntax
syntax on               " syntax highlighting
au BufReadPost *.module,*.install,*.theme,*.inc,*.test,*.profile set syntax=php

set autoindent                    "Preserve current indent on new lines
"# this one is more annoying than useful - ',pt' fixes perl anyhow
""set textwidth=78                  "Wrap at this column
set backspace=indent,eol,start    "Make backspaces delete sensibly

set tabstop=2                     "Indentation levels every four columns
set expandtab                     "Convert all tabs typed to spaces
set shiftwidth=2                  "Indent/outdent by four columns
set shiftround                    "Indent/outdent to nearest tabstop
" set softtabstop=0 smarttab nolist textwidth=0

"Set F2 to disable autoindenting if pasting into terminal in X
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set matchpairs+=<:>               "Allow % to bounce between angles too

"
set ai                  " auto indenting
set history=100         " keep 100 lines of history
set ruler               " show the cursor position
set hlsearch            " highlight the last searched term
filetype plugin on      " use the file type plugins
colors slate
 
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

"This is the XFT version of font names, if you have an old GTK 1.x version you
""+ need to use regular XFree86 font  names
"set guifont=ProFontWindows\ 9

" Map Ctrl+N to (temporarily)  disable search highlighting
nmap <silent> <C-N> :silent noh<CR>
" " Get rid of annoying errors when you do simple typos
map :W :w
map :Q :q
"
" " Settings...
set cindent
set ignorecase
set showmatch
set title
" set showmode
set ttyfast
set wildchar=<TAB>
"
" " Set the make program to the java compiler so you can compile
" " and jump between errors inside vim
set makeprg=php\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

"#################################
"# Customisations
"#################################
set showmode
set iskeyword+=:

