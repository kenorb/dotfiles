"####################
"#    Vim config    #
"# Author: kenorb   #
"####################

" Syntax highlighting
" ------------
syntax on               " syntax highlighting

" File specific settings
" ----------------------
au BufReadPost *.module,*.install,*.theme,*.inc,*.test,*.profile set syntax=php
au! BufWrite,FileWritePre *.module,*.install call RemoveWhiteSpace()

" Interface
" ------------
set showcmd                     " (sc) display an incomplete command in the lower right
set nocompatible                " (cp) use Vim defaults (much better)
set showmatch                   " (sm) briefly jump to matching bracket when inserting one
set autoindent                  " (ai) turn on auto-indenting and preserve current indent on new lines
set backspace=indent,eol,start  " (bs) allows backspacing beyond starting point of insert mode, indents and line breaks
set ruler                       " (ru) show the cursor position at all times
set vb                          " set visual bell
"set showmode                    " (smd) if in Insert, Replace or Visual mode put a message on the last line
"set guifont=ProFontWindows\ 9  " This is the XFT version of font names, if you have an old GTK 1.x version you need to use regular XFree86 font names

" Folding
"set foldcolumn=6                " (fdc) width of fold column (to see where folds are)
"set foldmethod=indent           " (fdm) creates a fold for every level of indentation
"set foldlevel=99                " (fdl) when file is opened, don't close any folds
"set foldenable                  " (fen) enables or disables folding

" Search
" case-insensitive search
set incsearch                   " (is) highlights what you are searching for as you type
set ignorecase                  " (ic) ignores case in search patterns
set smartcase                   " (scs) don't ignore case when the search pattern has uppercase
set infercase                   " (inf) during keyword completion, fix case of new word (when ignore case is on)

" Indenting
" ------------
" smartindent = tries to understand C
" cindent = smarter
set autoindent                  " (ai) copy indent from current line when starting a new line
set copyindent                  " (ci) when auto-indenting, use the indenting format of the previous line
set smartindent                 " (si) enable the smartindenting feature for the following files
set cindent
set tabstop=2                   " (ts) width (in spaces) that a <tab> is displayed as
set expandtab                   " (et) expand tabs to spaces (use :retab to redo entire file)
set shiftwidth=2                " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
set shiftround                  " (sr) indent/outdent to nearest tabstop
" set softtabstop=0 smarttab nolist textwidth=0

"Set F2 to disable autoindenting if pasting into terminal in X (aka don't mess with my indents)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" visible white space
set listchars=tab:>-,trail:.,eol:$

"
set history=100         " keep 100 lines of history
set hlsearch            " highlight the last searched term
set matchpairs+=<:>     "Allow % to bounce between angles too
filetype plugin on      " use the file type plugins
colors slate

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" Key mappings
" ------------

" Map Ctrl+N to (temporarily)  disable search highlighting
nmap <silent> <C-N> :silent noh<CR>
" " Get rid of annoying errors when you do simple typos
map :W :w
map :Q :q
" " Move to the next row which has non-white space character in the same column (Control-k/j).
:map <C-k> :call search('\%' . virtcol('.') . 'v\S', 'bW')<CR>
:map <C-j> :call search('\%' . virtcol('.') . 'v\S', 'wW')<CR>

" allows moving between split windows much faster and more intuitive
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_


"
" " Settings...
set ignorecase
set showmatch
set title
set ttyfast
set wildchar=<TAB>
"
" Set the make program to the java compiler so you can compile and jump between errors inside vim
set makeprg=php\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

" Customisations
" --------------
set iskeyword+=:
let html_use_css = 1            " the ':%TOhtml' command generates html without <font> tags

" Functions
" ------------------------------------------------------------
"
" Removes the ^M character from the end of every line
function! RemoveM()
    :%s/^M$//g
endfunction
" Replaces the ^M character with a carraige return native to the system
function! ReplaceM()
    :%s/^M/\r/g
endfunction
" Removes superfluous white space from the end of a line
function! RemoveWhiteSpace()
    :%s/\s*$//g
    :'^
    "`.
endfunction

" Command Reference
" -----------------
"
" *                     - searches for word under cursor
" gd                    - finds definition of variable/function under cursor
" ga                    - prints the ascii value of character under cursor
" gf                    - opens file under the cursor (in split view)
" gi                    - goes to insert mode in the same spot as you last inserted
" ~                     - changes case of character
" :r !<cmd>             - reads the output of the shell <cmd> into the file
" :% s/hello/A/gc       - typical search and replace command
"
" :% !tidy              - runs the code through the 'tidy' program
"
" :runtime! syntax/2html.vim
" :10,40TOhtml
"
" command reference ->  " za : fold toggle  toggles between a fold being opened and closed (zA does it recursively)
"                       " zc : fold close   close 1 fold under the cursor (zC does it recursively)
"                       " zo : fold open    open 1 fold under the cursor (zO does it recursively)
"                       " zm : fold more    increases foldlevel by 1 (zM opens all folds)
"                       " zr : fold reduce  decreses foldlevel by 1 (zR closes all folds)
"
" :retab                - when expandtab is set, replace all tabs in the file with the # of spaces defined in 'shiftwidth'
" :retab!               - when expandtab is not set, replace the number of spaces in 'shiftwidth' with a tab
