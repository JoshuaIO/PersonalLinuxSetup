syntax on
set number
set encoding=utf-8
set incsearch
set showmatch
set wildmenu
set wildmode=list:longest
set omnifunc=syntaxcomplete
"undo"
inoremap <C-z> <ESC>ui<CR>
"redo"
inoremap <C-S-z> <ESC><C-r>i<CR>
"find"
inoremap <C-f> <ESC>/
"Quick Save"
inoremap <C-S-s> <ESC>:w!
"Quick Quit"
inoremap <C-s-q> <ESC> :q!
"Auto Complete"
inoremap <S-a> <C-n>
inoremap <S-s> <C-p>

"Paste Inline"
inoremap <C-v> <ESC>pi
