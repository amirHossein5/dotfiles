let g:fzf_vim = {}

let g:fzf_vim.preview_window = ['hidden', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.87, 'yoffset': 0.3 } }
let $FZF_DEFAULT_OPTS = '--bind ctrl-k:preview-up,ctrl-j:preview-down --bind alt-a:select-all,alt-d:deselect-all'

function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
\ 'alt-q': function('s:build_quickfix_list'), }

command! -bang -nargs=* PFiles
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
\   'source': 'rg --hidden --files --ignore -g="!.git"',
\ }), <bang>0)

nmap <leader>pf :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <c-p> :PFiles<CR>
