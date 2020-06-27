function! s:p(bang, ...)
  let preview_window = get(g:, 'fzf_preview_window', a:bang && &columns >= 80 || &columns >= 120 ? 'right': '')
  if len(preview_window)
    return call('fzf#vim#with_preview', add(copy(a:000), preview_window))
  endif
  return {}
endfunction

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always  ".shellescape(<q-args>), 1, s:p(<bang>0), <bang>0)
