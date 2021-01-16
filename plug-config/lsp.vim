" LSP Run server setup
lua << EOF

require'lspconfig'.intelephense.setup{ 
	init_options = {
		licenceKey = '/Users/iwanphillips/.config/intelephense/licence.txt' 
	};
    on_attach=function(client)
        require('completion').on_attach(client)
        require('illuminate').on_attach(client) 
    end,
}
require'lspconfig'.tsserver.setup{ 
    on_attach=function(client)
        require('completion').on_attach(client) 
        require('illuminate').on_attach(client) 
    end,
}
require'lspconfig'.vuels.setup{ 
    on_attach=function(client)
        require('completion').on_attach(client) 
        require('illuminate').on_attach(client) 
    end,
}

EOF


function! LSPSetMappings()
	setlocal omnifunc=v:lua.vim.lsp.omnifunc

    nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <buffer> <c-h> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <buffer> gR    <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

    nnoremap <silent> <buffer> ga    		<cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <buffer> <leader>f    <cmd>lua vim.lsp.buf.formatting()<CR>
endfunction

au FileType vue,js,ts,php,module :call LSPSetMappings()
autocmd BufWritePre vue,js,ts,php,module
    \ lua vim.lsp.buf.formatting_sync(nil, 1000)

