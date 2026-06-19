local wk = require("which-key")
wk.setup({
	win = {
		border = "rounded",
		title = true,
	},
})
wk.add({
	{ "<leader>?", function() wk.show({ global = false }) end, desc = "Buffer Local Keymaps" },
})
