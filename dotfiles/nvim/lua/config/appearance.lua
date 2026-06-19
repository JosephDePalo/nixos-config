vim.cmd([[colorscheme gruvbox]])
vim.opt.termguicolors = true

local function remove_bg(group)
	local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
	hl.bg = "NONE"
	vim.api.nvim_set_hl(0, group, hl)
end

local elements = {
	"Normal",
	"TabLineFill",
	"SignColumn",
	"DiagnosticSignWarn",
	"DiagnosticSignError",
	"DiagnosticSignHint",
	"DiagnosticSignInfo",
	"DiagnosticSignOk",
}
for _, elem in ipairs(elements) do
	remove_bg(elem)
end

vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 8
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.textwidth = 79
vim.opt.laststatus = 0
