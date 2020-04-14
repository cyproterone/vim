""#################### ############### ####################
""#################### Requires Region ####################
""#################### ############### ####################

let s:plugin_dir=expand('$HOME/.vim/plugged')
call plug#begin(s:plugin_dir)

""#################### ########### ####################
""#################### Misc Region ####################
""#################### ########### ####################

" better defaults
Plug 'tpope/vim-sensible'


""#################### ################# ####################
""#################### Navigation Region ####################
""#################### ################# ####################

" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


""#################### ############## ####################
""#################### Sidebar Region ####################
""#################### ############## ####################

" file tree
Plug 'preservim/nerdtree'


""#################### ############ ####################
""#################### Theme Region ####################
""#################### ############ ####################

" powerline
Plug 'vim-airline/vim-airline'


" colour scheme
Plug 'junegunn/seoul256.vim'


" iconpack
Plug 'ryanoasis/vim-devicons'


""#################### ############# ####################
""#################### Editor Region ####################
""#################### ############# ####################

" git gutter
Plug 'airblade/vim-gitgutter'


" multi cursors
Plug 'terryma/vim-multiple-cursors'


" enforce consistent style
Plug 'editorconfig/editorconfig-vim'


"#################### END ####################
call plug#end()
