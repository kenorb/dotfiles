"####################
"#    Vim config    #
"# Author: kenorb   #
"####################

syntax on               " syntax highlighting
set nocompatible        " (cp) use Vim defaults (much better)

" File specific settings
" ----------------------
au BufReadPost *.php,*.module,*.inc,*.install,*.test,*.profile,*.theme
  \ set syntax=php | set ff=unix |
  \ let g:syntastic_php_phpcs_args="--standard=Drupal --extensions=php,module,inc,install,test,profile,theme"
" au! BufWrite,FileWritePre *.module,*.install call RemoveWhiteSpace()
au BufReadPost *.mq4,*.mq5,*.mqh set syntax=c | set ts=2 | set sts=2 | set sw=2 | set ff=unix
au BufReadPost *.py set ts=4 | set sts=4 | set sw=4 | set ff=unix

" Workaround for crontab (See: http://vi.stackexchange.com/q/137/467)
au BufNewFile,BufRead crontab.* set nobackup | set nowritebackup | set ff=unix

" Interface
" ------------
set showcmd                     " (sc) display an incomplete command in the lower right
set showmatch                   " (sm) briefly jump to matching bracket when inserting one
set autoindent                  " (ai) turn on auto-indenting and preserve current indent on new lines
set backspace=indent,eol,start  " (bs) allows backspacing beyond starting point of insert mode, indents and line breaks
set ruler                       " (ru) show the cursor position at all times
set visualbell                   " (vb) set visual bell
"set showmode                    " (smd) if in Insert, Replace or Visual mode put a message on the last line
"set guifont=ProFontWindows\ 9  " This is the XFT version of font names, if you have an old GTK 1.x version you need to use regular XFree86 font names
set encoding=utf-8

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

" Formatting
set ff=unix

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

" Options
" -------
set nodigraph                   " (dg) Enable the entering of digraphs in Insert mode. See: http://vi.stackexchange.com/q/2254/467
set mouse=a

" Key mappings
"
" Set F2 to disable autoindenting if pasting into terminal in X (aka don't mess with my indents)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
" TABS
" To create a new tab (Control-T)
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
" Tab Navigation (Control+Left <-> Control-Right, Shift+H <-> Shift+L).
nnoremap <S-h> gT
nnoremap <S-l> gt
nnoremap <A-Left> gT               " @fixme?
nnoremap <A-Right> gt              " @fixme?
nnoremap <C-S-Tab> gT              " @fixme?
nnoremap <C-Tab> gt                " @fixme?
" Tab Close (Control-W)
nnoremap <C-BS> :tabclose<CR>      " @fixme?
inoremap <C-BS> <Esc>:tabclose<CR> " @fixme?
" Close All (Control-Q)
nnoremap <C-q> :qa<CR>
inoremap <C-q> <Esc>:qa<CR>


" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" visible white space
set listchars=tab:>-,trail:.,eol:$

"
set history=100         " keep 100 lines of history
set matchpairs+=<:>     "Allow % to bounce between angles too
filetype plugin on      " use the file type plugins
colors slate

set hlsearch!           " highlight the last searched term
" toggle highlighting (@see: http://stackoverflow.com/a/657457)
nnoremap <F3> :set hlsearch!<CR>

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
map <C-k> :call search('\%' . virtcol('.') . 'v\S', 'bW')<CR>
map <C-j> :call search('\%' . virtcol('.') . 'v\S', 'wW')<CR>
map <A-Up> :call search('\%' . virtcol('.') . 'v\S', 'bW')<CR>   " @fixme
map <A-Down> :call search('\%' . virtcol('.') . 'v\S', 'wW')<CR> " @fixme

" allows moving between split windows much faster and more intuitive
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_

" Map Ctrl+s to save file.
map <C-s> :w <CR>
imap <C-s> <Esc> :w <CR>

" Map Shift-Up/Shift-Down for moving a line up and down.
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

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

" Ensure private editing.
" Usage - VIM_PRIVATE=1 vim
if $VIM_PRIVATE
  set nobackup
  set nowritebackup
  set noundofile
  set noswapfile
  set viminfo=""
  set noshelltemp
  set history=0
  set nomodeline
  set secure
endif

" Drupal Code Sniffer integration
" -------------------------------
if exists('g:loaded_syntastic_plugin') && has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\ " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y] " filetype
  set statusline+=\ [%{getcwd()}] " current dir
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_enable_signs=1
  set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

" vim-airline integration
" -------------------------------
if exists('g:syntastic') && has('statusline')
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif

" Commands
" ---------

" @see: http://vi.stackexchange.com/a/10291
" Define the default highlight group.
hi link Match Search
"
":[range]SelectRange    Create a linewise visual selection of [range].
command! -bar -range SelectRange execute "normal! m'" | call cursor(<line1>, 1) | execute 'normal! V' | call cursor(<line2>, 1)
"
":[range]MatchLines [{group}]
"           Highlight the lines in [range] with the "Match" group /
"           {group}. This only considers the line numbers, not their
"           contents.
command! -bar -range -nargs=? MatchLines execute 'match' (empty(<q-args>) ? 'Match' : <q-args>) printf('/\%%>%dl\%%<%dl/', (<line1> - 1), (<line2> + 1))
"
":[range]MatchRange [{group}]
"           Highlight the content of the lines in [range] with the
"           "Match" group / {group}. This considers the current
"           content of the lines (also elsewhere in the buffer).
command! -bar -range -nargs=? MatchRange execute 'match' (empty(<q-args>) ? 'Match' : <q-args>) '/\V\^' . join(map(getline(<line1>, <line2>), 'escape(v:val, "\\/")'), '\n') . '\$/'


" Functions
" ---------
"
" Removes the ^M character from the end of every line
function! RemoveM()
    :%s/^M$//ge
endfunction
" Replaces the ^M character with a carraige return native to the system
function! ReplaceM()
    :%s/^M/\r/ge
endfunction
" Removes superfluous white space from the end of a line
function! RemoveWhiteSpace()
    :%s/\s\+$//e
":'^
"`.
endfunction
function! UseTabs()
  set autoindent
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
endfunction

" Initialize plugins.
" ---------
"
if exists('pathogen#infect')
  execute pathogen#infect()
endif

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
