nnoremap <Leader>tn :w<CR> <C-w>o :silent TestNearest<CR>
nnoremap <Leader>tf :w<CR> <C-w>o :TestFile<CR>
nnoremap <Leader>ts :w<CR> <C-w>o :TestSuite<CR>
nnoremap <Leader>tl :w<CR> <C-w>o :TestLast<CR>
nnoremap <Leader>tw :w<CR> :TestVisit<CR>

let g:test#neovim#start_normal = 1
let g:test#strategy = 'neovim'
