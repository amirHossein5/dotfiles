nnoremap <Leader>tn :w<CR> :tabonly<CR> :silent TestNearest<CR>
nnoremap <Leader>tf :w<CR> :tabonly<CR> :TestFile<CR>
nnoremap <Leader>ts :w<CR> :tabonly<CR> :TestSuite<CR>
nnoremap <Leader>tl :w<CR> :tabonly<CR> :TestLast<CR>
nnoremap <Leader>tw :w<CR> :TestVisit<CR>

let g:test#basic#start_normal = 1
let test#php#phpunit#executable = 'phpunit'
