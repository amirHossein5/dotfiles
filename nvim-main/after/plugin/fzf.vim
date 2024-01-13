let $FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name ''*.tags'' -printf ''%P\n'''
command! GF call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --cached --others'}))

let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden,right,50%', 'ctrl-/']

nnoremap <leader>pf :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <C-t> :BTags<CR>
nnoremap <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GF' : 'Files'<CR>
nnoremap <leader>ps :Rg<CR>
