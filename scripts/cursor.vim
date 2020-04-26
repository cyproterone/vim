" Prevent vim from moving cursor 1 step back

let b:CursorColumnI = 0 "the cursor column position in INSERT
augroup cursor_pos
  autocmd!
  autocmd InsertEnter * let b:CursorColumnI = col('.')
  autocmd CursorMovedI * let b:CursorColumnI = col('.')
  autocmd InsertLeave * if col('.') != b:CursorColumnI | call cursor(0, col('.')+1) | endif
augroup END
