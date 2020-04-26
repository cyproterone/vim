" Prevent vim from moving cursor 1 step back

let s:CursorColumnI = 0 "the cursor column position in INSERT
augroup cursor_pos
  autocmd!
  autocmd InsertEnter * let s:CursorColumnI = col('.')
  autocmd CursorMovedI * let s:CursorColumnI = col('.')
  autocmd InsertLeave * if col('.') != s:CursorColumnI | call cursor(0, col('.')+1) | endif
augroup END
