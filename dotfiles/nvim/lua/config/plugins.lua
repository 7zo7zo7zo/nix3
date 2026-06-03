vim.pack.add({
	'https://github.com/saghen/blink.lib',
	'https://github.com/Saghen/blink.cmp',
	{ src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range("v2.*") },
	'https://github.com/saghen/blink.pairs',
	'https://github.com/saghen/blink.indent',
	'https://github.com/lervag/vimtex',
	'https://github.com/evesdropper/luasnip-latex-snippets.nvim',
	'https://github.com/brenoprata10/nvim-highlight-colors',
	'https://github.com/rebelot/kanagawa.nvim',
})

local cmp = require('blink.cmp')

cmp.build():pwait()
cmp.setup({
	keymap = { preset = 'default' },
	completion = { documentation = { auto_show = false } },
	snippets = { preset = 'luasnip' },
	sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

local pairs = require('blink.pairs')

pairs.build():pwait()
pairs.setup()

require('nvim-highlight-colors').setup()

vim.cmd.colorscheme('kanagawa')
