""#################### ################# ####################
""#################### Navigation Region ####################
""#################### ################# ####################

" select auto complete result
set wildmenu

set wildmode=longest,list,full

" Exclude files completion
set complete-=i

" show command history
set showcmd


""#################### ########## ####################
""#################### FZF Region ####################
""#################### ########## ####################

" fzf all commands
map <silent> <leader>p :Command<CR>

" fzf command hist
map <silent> <leader>h :History:<CR>

" fzf rg
map <silent> <leader>r :Rg<CR>

" fzf swoop
map <silent> <leader>s :BLines<CR>
