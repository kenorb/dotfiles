set tabstop=2 shiftwidth=2 softtabstop=0 smarttab expandtab nolist textwidth=0
syntax on               " syntax highlighting
au BufReadPost *.module,*.install,*.theme,*.inc,*.test,*.profile set syntax=php

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
" " Custom settings
" 
