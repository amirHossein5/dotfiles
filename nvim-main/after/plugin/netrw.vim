function! NetrwMapping()
  nmap <buffer> h -
  nmap <buffer> l <CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

