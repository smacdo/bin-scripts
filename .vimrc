"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scott's .vimrc                                                          "
" ----------------------------------------------------------------------- "
" Custom Command List                                                     "
" --------------------                                                    "
"                                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
" TODO: Only source this on debian, source correct platform specific.
runtime! debian.vim

" Use Vim settings rather than vi settings. Avoid side effects if compatible
" is already reset.
if &compatible
    set nocompatible
endif

" My default editor theme is molkai.
colorscheme molokai

" Basic editor settings.
set history=1000  " Keep 100 lines of command history. You know, just in case.
set expandtab     " Insert $softtabstop amount of spaces when tab is pushed instead of \t.
set tabstop=4     " Change width of hard tab to 4 spaces.
set shiftwidth=4  " Use 4 spaces when auto indenting, hitting >> << or ==.
set softtabstop=4 " Treat 4 spaces as a tab when hitting tab, deleting etc. 
set shiftround    " Round indent to multiple of shiftwidth ('>', '<').
set autoindent    " Copies indentation from previous line when starting a new line.
set textwidth=120 " Maximum width of text that is being inserted before being broken up.
set number        " Display line numbers in left column.
set showmode      " Shows mode at bottom (ie --INSERT--).
set wildmode=list:longest,full " Bash-like tab completion when in conmmand prompt.
set ruler         " Show line/col pos in status line
set showmatch     " Always show matching brace under cursor
set noerrorbells  " System bell is pure evil
set background=dark " Set dark background for colors
set bg=dark       " Set dark background for colors
set autoread      " Set readonly when file is external modified.
set showcmd       " Show (partial) command in status line.
set ignorecase    " Case insensitive matching.
set smartcase     " Overrides ignorecase when at least one non-lowercase character is present.
set incsearch     " Incremental search. Hit `<CR>` to stop.
set autowrite     " Automatically save before commands like :next, :make etc.
set hidden        " Possibility to have more than one unsaved buffer.
set hlsearch      " Highlight all search pattern mathes.
set laststatus=2  " Always draw a status line even if there is only one window.
set scrolloff=1   " Keep two lines above/below cursor when scrolling up/down.
set sidescrolloff=5 " Keep five characters to left/right when scrolling horizontally.
set confirm       " Use dialog to ask if save changes instead of error.
set backup        " Enable automatic backups.
set backupdir=~/.vim_runtime/backups " Store backups in a central location.
set directory=~/.vim_runtime/tmp     " Keep .swp files in one out of the way directory.

" Automatically switches to the directory that the document is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Make backspace act as expected on some weirdly configured platforms
set backspace=eol,start,indent

" Map <F2> to enable/disable vim's auto ident on paste. This allows us to paste code without
" having the auto indentation rules applied.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Hit % on a 'if' to jump to the corresponding else.
runtime macros/matchit.vim
 
" have error messages red on white
highlight ErrorMsg guibg=White guifg=Red

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Persistent undo
try
    if MySys() == "windows"
        set undodir=C:\Windows\Temp
    else
        set undodir=~/.vim_runtime/undo
    endif

    set undofile
catch
endtry

" Set guide bar at 100 characters.
if exists('&colorcolumn')
    set colorcolumn=100
    highlight ColorColumn ctermbg=0 guibg=lightgrey
endif

" Case insensitive file name completion.
if exists('&wildignorecase')
    set wildignorecase
endif

" Enable file detection and turn on automatic syntax highlighting, indenting and other features
" for files with a detected language.
if has('autocmd')
    filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" Highlight strings and numbers inside of C comments.
let c_comment_strings=1

" Set the amount of time for vim to wait to see if a key is part of a multi-key command to
" 100ms.
if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

" Use <C-L> to clear the highlighting from :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    noremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Don't use Ex mode. Instead use Q for formatting. Revert this wtith ":unma Q"
map Q qq

" Most modern terminal support the mouse, so lets turn it on. Only xterm can grab the mouse
" event using the shift key; for other terminals use ":", select the text and press Esc.
if has('mouse')
    if &term =~ 'xterm'
        set mouse=a
    else
        set mouse=nvi
    endif
endif

" Apply GUI specific settings.
if has("gui_running")
    " Get rid of the tearoff menu entries in Windows.
    if has('win32')
        set guioption-=t
    endif

    " Show more lines and columns in GUI mode. Assumes GUI running with decent resolution.
    set lines=36
    set columns=125

    " Set a nice font. Note that Consolas isn't available by default on Linux,
    " but you can easily extract it from Microsoft's PPT installer. Its a nice
    " font made specifically for programmers!
    if has("mac")
        set guifont=Monaco:h10
    elseif has("unix")
        " TODO: Can we detect which fonts are installed in order of preference?
        set guifont=Consolas\ 12
        "set guifont=Ubuntu\ Mono\ 11
        "set guifont=Liberation\ Mono\ 10
    elseif has("win32")
        set guifont=Consolas\ 10
    endif
else
    " Settings specific to non-GUI instances.
endif

" Remap apple keys, useful because i always hit apple instead of ctrl
if has("mac")
    cmap <D-f> <C-f>
    cmap <D-b> <C-b>
endif
