-- LSP servers installed via nix (programs.neovim.extraPackages)
-- lspconfig 2.10+ provides server configs via lsp/*.lua (loaded automatically by nvim 0.11+)
vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.lsp.enable({ "lua_ls", "pyright", "nixd" })
