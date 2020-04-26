function! s:StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun


augroup trim_whitesapce
  autocmd!
  autocmd BufWritePre * call s:StripTrailingWhitespaces()
augroup END
