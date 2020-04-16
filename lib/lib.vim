""#################### ############### ####################
""#################### Requires Region ####################
""#################### ############### ####################

let s:plugin_dir=expand('$HOME/.vim/plugged')
call plug#begin(s:plugin_dir)


""#################### Help Region ####################

" whichkey from emacs
Plug 'liuchengxu/vim-which-key'


""#################### LSP Region ####################

" " LSP server
" Plug 'neoclide/coc.nvim'


" " LSP symbol viewer
" Plug 'liuchengxu/vista.vim'


" " connect to SQL servers
" Plug 'vim-dadbod'


""#################### Cursors Region ####################

" repeat prev actions
Plug ''

"#################### END ####################
call plug#end()
