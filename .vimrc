" -----------------------
" General
" -----------------------
syntax on           " syntax highlighting
set nocompatible    " dissable vi compatibility
set ruler           " show position at bottom
set mouse=a         " mouse support

" -----------------------
" Appearance
" -----------------------
set cursorline      " underline cursor line
" turn cursorline into solid background
hi CursorLine cterm=NONE ctermbg=236 guibg=#3c3836

set relativenumber  " line numbers relative to cursor 
" apply stile to relativenumbers
hi LineNr cterm=NONE 
hi CursorLineNr cterm=NONE ctermbg=236 

" visualize tabs
set list
set listchars=tab:\¦\ 

set noexpandtab     " real tab characters, not spaces
set tabstop=4       " tab counts as 4 spaces visually
set shiftwidth=4    " >> and << shift by 4 (same as tabstop)

" -----------------------
" Coding
" -----------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
