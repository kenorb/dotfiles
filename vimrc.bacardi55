" Maintainer:   Raphael Khaiat <raphael@khaiat.org>
" Last change:  2010 Mars 04
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

call pathogen#infect()

set history=100     " keep 100 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching
set ignorecase      " pas de différence entre majuscule et minuscule
set smartcase
set infercase
set undolevels=150  " Undo : revenir en arrière
set t_Co=256        " En cas d'utilisation en remote, on met à 256 couleurs
set nu
set wildmenu "pour la completion dans la bar en bas

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme zenburn
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  filetype on
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
  augroup END
else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

if has("spell")
    " Les dictionnaires seront télécharges automatiquement si le répertoire ~/.vim/spell existe
    if !filewritable($HOME."/.vim/spell")
        call mkdir($HOME."/.vim/spell", "p")
    endif
    set spellsuggest=10 " La commande z= affiche des suggestions, je n'en veux que 10 pour ne pas surcharger l'écran
    " On règle les touches d'activation manuelle de la correction orthographique
    noremap ,sf :setlocal spell spelllang=fr <CR>
    noremap ,se :setlocal spell spelllang=en <CR>
    noremap ,sn :setlocal nospell <CR>
    " On active automatiquement le mode spell pour les fichiers texte et LaTeX
    autocmd BufEnter *.txt,*.tex setlocal spell
    autocmd BufEnter *.txt,*.tex setlocal spelllang=fr
endif


" Backup
if !filewritable($HOME."/.vim/backup") " Si le répertoire n'existe pas
    call mkdir($HOME."/.vim/backup", "p") " Création du répertoire de sauvegarde
endif
set backupdir=$HOME/.vim/backup " On définit le répertoire de sauvegarde
set backup " On active le comportement


" Status Bar
set laststatus=2 " Affiche la barre de statut quoi qu'il en soit (0 pour la masquer, 1 pour ne l'afficher que si l'écran est divise)
if has("statusline")
    set statusline=\ %f%m%r\ [%{strlen(&ft)?&ft:'aucun'},%{strlen(&fenc)?&fenc:&enc},%{&fileformat},ts:%{&tabstop}]%=%l,%c%V\ %P
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
elseif has("cmdline_info")
    set ruler " Affiche la position du curseur en bas a gauche de l'écran
endif

" Quand un fichier est changé en dehors de Vim, il est relu automatiquement
set autoread
set title

" Aucun son ou affichage lors des erreurs
set errorbells
set novisualbell
set t_vb=

" Quand une fermeture de parenthèse est entrée par l'utilisateur,
" l'éditeur saute rapidement vers l'ouverture pour montrer où se
" trouve l'autre parenthèse. Cette fonction active aussi un petit
" beep quand une erreur se trouve dans la syntaxe.
set showmatch
set matchtime=2

" identation
set cindent
set smartindent

" Tabs
map ,t :tabnew<cr>
map ,w :tabclose<cr>
imap <C-t> <Esc><C-t>
imap <C-w> <Esc><C-w>
map <tab> gt
map <S-tab> gT

" Les tab et autres :
set tabstop=2       " nombre d'espaces par tab
set shiftwidth=2    " nombre de caractère utilisé pour l'indentation
set softtabstop=2   " pour que backspace supprime 4 espaces:
set expandtab       " Remplace les tab par des espaces

set scrolloff=10

"set ttymouse=xterm2 " pour avoir la souris même dans screen
set ttymouse=xterm  " pour avoir la souris même dans tmux

set winwidth=110
set winheight=30

" Pour insérer un saut de ligne en mode normal :
map <S-r> i<CR><ESC>

" Ferme une parenthese, et se place entre les deux, a mettre dans le .vimrc
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap '' ''<left>
inoremap "" ""<left>
inoremap , , 
"php
inoremap <? <?php<space><space>?><left><left><left>

" sur pression de la touche F3 highlight les charactères qui dépassent la
" 80ème colonne
map <silent> <F3> "<Esc>:match ErrorMsg '\%>80v.\+'<CR>"
map <silent> <F4> "<Esc>:match ErrorMsg '\%>800v.\+'<CR>"

" La list des méthodes/variables
nnoremap <F9> :TlistToggle<CR>
" Je préfère la placer à droite
let Tlist_Use_Right_Window = 1

nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" plugin symfony pour vim
silent map <F10> :SfSwitchView <CR>

" Reglages pour le php
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_folding = 1

" Quick jumping between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" pour effacer les espaces de fin de ligne
map <F6> :%s/\s*$//<CR>

" pour xptemplate
filetype plugin on
let g:xptemplate_key="<C-c>"
let g:xptemplate_nav_next="&"
let g:xptemplate_nav_prev="<S-&>"

" pour sparkup
let g:sparkupNextMapping="<C-b>"

cab wr w !sudo tee %

"syntastic
let g:syntastic_check_on_open=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_jump=1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['php'], 'passive_filetypes': ['python'] }
