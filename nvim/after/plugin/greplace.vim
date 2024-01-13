set grepprg=rg
let g:grep_cmd_opts='--hidden --sort-files --line-number --no-heading --type-add "tag:tags" -Ttag -g "!.git/"'
let g:grep_default_file_names='.'

nnoremap <leader>gsl :Gsearch -F<CR>
nnoremap <leader>gsr :Gsearch<CR>

nnoremap <leader>gsnil :Gsearch --no-ignore -F<CR>
nnoremap <leader>gsnir :Gsearch --no-ignore<CR>

nnoremap <leader>gr :Gqfopen<CR>
