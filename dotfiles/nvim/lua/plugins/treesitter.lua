-- grammars are bundled by nix (nvim-treesitter.withAllGrammars)
-- nvim-treesitter v0.10 removed the configs module; highlighting is now built into neovim
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local ok = pcall(vim.treesitter.start)
		if not ok then
			vim.cmd("syntax on")
		end
	end,
})
