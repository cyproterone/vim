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


""#################### ########### ####################
""#################### Help Region ####################
""#################### ########### ####################

" whichkey from emacs
Plug 'liuchengxu/vim-which-key'


""#################### ################# ####################
""#################### Navigation Region ####################
""#################### ################# ####################

" fuzzy search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'


""#################### ################# ####################
""#################### Navigation Region ####################
""#################### ################# ####################

" swap window positions
Plug 'wesQ3/vim-windowswap'


" resize active windows
Plug 'roman/golden-ratio'


""#################### ############## ####################
""#################### Sidebar Region ####################
""#################### ############## ####################

" file tree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'


""#################### ############ ####################
""#################### Theme Region ####################
""#################### ############ ####################

" powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" colour scheme
Plug 'junegunn/seoul256.vim'
Plug 'ayu-theme/ayu-vim'


" iconpack
Plug 'ryanoasis/vim-devicons'


""#################### ################# ####################
""#################### Versioning Region ####################
""#################### ################# ####################

" git gutter
Plug 'airblade/vim-gitgutter'

" view git history
Plug 'junegunn/gv.vim'


""#################### ########## ####################
""#################### LSP Region ####################
""#################### ########## ####################

" LSP server
Plug 'neoclide/coc.nvim'


" LSP symbol viewer
Plug 'liuchengxu/vista.vim'


""#################### ############# ####################
""#################### Editor Region ####################
""#################### ############# ####################

" expand region
Plug 'terryma/vim-expand-region'


" multi cursors
Plug 'terryma/vim-multiple-cursors'


" drag regions around
Plug 'matze/vim-move'


" enforce consistent style
Plug 'editorconfig/editorconfig-vim'


"#################### END ####################
call plug#end()
