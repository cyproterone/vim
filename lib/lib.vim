""#################### ############### ####################
""#################### Requires Region ####################
""#################### ############### ####################

let s:plugin_dir=expand('$HOME/.vim/plugged')

call plug#begin(s:plugin_dir)


" better defaults
Plug 'tpope/vim-sensible'


" fuzzy search
Plug 'junegunn/fzf.vim'


" colour scheme
Plug 'junegunn/seoul256.vim'


" powerline
Plug 'vim-airline/vim-airline'


call plug#end()
