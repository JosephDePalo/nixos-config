vim.api.nvim_create_autocmd("FileType", {
	pattern = "mail",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.textwidth = 72
	end,
})
