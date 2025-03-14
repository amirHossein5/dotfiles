return {
    dependencies = { 'junegunn/fzf', run = "fzf#install()" },
    keys = { "<c-p>" },
    "junegunn/fzf.vim",
    config = function()
        vim.cmd([[
            let g:fzf_vim = {}

            let g:fzf_vim.preview_window = ['hidden', 'ctrl-/']
            let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.87, 'yoffset': 0.3 } }
            let $FZF_DEFAULT_OPTS = '--bind ctrl-k:preview-up,ctrl-j:preview-down --bind alt-a:select-all,alt-d:deselect-all'
            let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'gutter':  ['bg', 'Normal'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

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

        ]])

        vim.keymap.set('n', '<leader>pf', ':Files<CR>')
        vim.keymap.set('n', '<leader>b', ':Buffers<CR>')
        vim.keymap.set('n', '<c-p>', ':PFiles<CR>')
    end
}
