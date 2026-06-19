local function noremap(keys, func, opts)
	vim.keymap.set("n", keys, func, opts)
end

noremap("<Esc>", function()
	vim.cmd.nohlsearch()

	vim.cmd.pclose()
	local win_id = vim.api.nvim_get_current_win()
	local config = vim.api.nvim_win_get_config(win_id)
	if config.relative ~= "" then
		vim.api.nvim_win_close(win_id, false)
	end
end, { desc = "Clear Highlights & Close Floating" })

noremap("<leader>e", "<cmd>NvimTreeOpen<CR>", { desc = "Explorer at CWD" })

noremap("<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
noremap("<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
noremap("<leader>bd", "<cmd>Bdelete<CR>", { desc = "Close Buffer" })

noremap("<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
noremap("<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
noremap("<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
noremap("<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

noremap("<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
noremap("<leader>-", "<cmd>split<CR>", { desc = "Horizontal Split" })
noremap("<leader>wd", "<cmd>close<CR>", { desc = "Close Window" })

noremap("<leader>tn", "<cmd>tabnew<CR>", { desc = "New Tab" })
noremap("<leader>td", "<cmd>tabclose<CR>", { desc = "Close Tab" })
noremap("<leader>[t", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
noremap("<leader>]t", "<cmd>tabnext<CR>", { desc = "Next Tab" })

local builtin = require("telescope.builtin")
noremap("<leader>ff", builtin.find_files, { desc = "Search Files" })
noremap("<leader>fg", builtin.live_grep, { desc = "Live Grep" })
noremap("<leader>fb", builtin.buffers, { desc = "Search Buffers" })
noremap("<leader>fh", builtin.help_tags, { desc = "Search Help Tags" })
noremap("<leader>fc", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search Config Files" })
noremap("<leader>fF", function()
	builtin.find_files({ cwd = vim.fn.expand("~") })
end, { desc = "Search Home Directory" })

noremap("<leader>g", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

noremap("<C-k>", function()
	vim.cmd("vertical Man " .. vim.fn.expand("<cword>"))
end, { silent = true, desc = "Open Man Page for Word" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "man", "help", "qf" },
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>bdelete<CR>", {
			buffer = event.buf,
			silent = true,
			desc = "Close buffer and window",
		})
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function lspmap(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
		end
		lspmap("<leader>cd", vim.diagnostic.open_float, "Show Diagnostic")

		lspmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		lspmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
		lspmap("[w", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
		end, "Previous Warning")
		lspmap("]w", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
		end, "Next Warning")
		lspmap("[e", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, "Previous Error")
		lspmap("]e", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, "Next Error")

		lspmap("<leader>cl", vim.diagnostic.setloclist, "List Diagnostics")
		lspmap("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
		lspmap("<leader>ca", vim.lsp.buf.code_action, "Code Actions")
	end,
})

noremap("<leader>cf", function()
	pcall(require("conform").format, {
		lsp_fallback = true,
		async = true,
	})
end, { desc = "Code Format" })
noremap("<leader>cl", "<cmd>LspInfo<CR>", { desc = "Show LSP Info" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })
