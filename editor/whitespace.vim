""#################### ################# ####################
""#################### Whitespace Region ####################
""#################### ################# ####################

" indent using spaces
set expandtab

" auto indent
set autoindent
set smarttab


" remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
