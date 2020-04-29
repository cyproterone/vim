augroup trim_whitesapce
  autocmd!
  autocmd BufWritePre * lua require 'layers'.strip_whitespace()
augroup END
