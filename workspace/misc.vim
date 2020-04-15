""#################### ########### ####################
""#################### Misc Region ####################
""#################### ########### ####################

set encoding=utf-8

" faster redrawing
set ttyfast

" show as much as possible
set display=lastline

" more history
set history=10000

" viminfo include !
set viminfo+=!


""#################### ########### ####################
""#################### Undo Region ####################
""#################### ########### ####################

" persistent undo
set undofile
set undodir=expand("$HOME/.vim/undo")

" maximum number of changes that can be undone
set undolevels=1000

" maximum number lines to save for undo on a buffer reload
set undoreload=10000
