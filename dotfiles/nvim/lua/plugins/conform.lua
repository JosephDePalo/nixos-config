require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier", stop_after_first = true },
		tex = { "tex-fmt" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = { timeout_ms = 500 },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
