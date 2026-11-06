" -----------------------
" General
" -----------------------
syntax on           " syntax highlighting
set nocompatible    " dissable vi compatibility
set scrolloff=15    " minimum lines above and below cursor

" -----------------------
" Appearance
" -----------------------
set cursorline      " underline cursor line
" turn cursorline into solid background
hi CursorLine cterm=NONE ctermbg=236 guibg=#3c3836

set ruler           " show position at bottom
"set rulerformat=%f\ %l\,%c%=%p%%
set rulerformat=%30(%f%)%=%m%l\,%c\ %p%%

set relativenumber  " line numbers relative to cursor 
" apply style to relativenumbers
hi LineNr cterm=NONE 
hi CursorLineNr cterm=NONE ctermbg=236 

" visualize tabs
set list
set listchars=tab:\¦\ 
set noexpandtab     " real tab characters, not spaces
set tabstop=4       " tab counts as 4 spaces visually
set shiftwidth=4    " >> and << shift by 4 (same as tabstop)

" visualize linebrak
set showbreak=··\ 

" -----------------------
" Coding
" -----------------------
" inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
" below changes autocomplete shortcut
inoremap <C-y> <C-n>
set showmatch       " show matching bracket

" -----------------------
" Search
" -----------------------
set hlsearch        " highlight during search
set ignorecase      " ignore case on search


" -----------------------
" Commands
" -----------------------
function! InsertTable()
    call append(line('.'), [
        \ '| 1 | 2 | 3 |',
        \ '|---|---|---|',
        \ '| x | x | x |',
        \ '| x | x | x |'
        \ ])
endfunction

command! Table call InsertTable()

command! Cat write | !cat %

command! Glow write | !glow %
" corresponding shortcut
nnoremap <C-g> :Glow<CR>
