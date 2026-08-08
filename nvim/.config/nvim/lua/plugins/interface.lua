vim.pack.add({
	"https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
}, { confirm = false })

vim.o.background = "dark"
vim.o.termguicolors = true

require("nightfox").setup({
	options = {
		styles = { comments = "italic", keywords = "bold", types = "italic,bold" },
	},
})
require("rose-pine").setup({
	variant = "moon",
})
vim.cmd.colorscheme("rose-pine-moon")

require("lualine").setup({
	options = { icons_enabled = true, theme = "rose-pine" },
	sections = {
		lualine_c = { { "filename", path = 1 } },
	},
})

require("nvim-tree").setup({
	view = {
		side = "left",
		width = {
			min = 28,
			max = 42,
		},
	},
})

require("nvim-autopairs").setup({})

require("render-markdown").setup({})
