""#################### ############## ####################
""#################### Windows Region ####################
""#################### ############## ####################

" nnoremap <leader>= :split
" nnoremap <leader>-
map <silent> <leader>w :quit<CR>



""#################### ############ ####################
""#################### Panes Region ####################
""#################### ############ ####################

" consistent splitting direction
set splitright
set splitbelow


" split panes
map <silent> <leader>- :split<CR>
map <silent> <leader>= :vsplit<CR>


" move pane focus
map <silent> <A-Up> :wincmd k<CR>
map <silent> <A-Down> :wincmd j<CR>
map <silent> <A-Left> :wincmd h<CR>
map <silent> <A-Right> :wincmd l<CR>
