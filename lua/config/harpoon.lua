-- Harpoon configuration
local harpoon = require("harpoon")

print("harpoon - setup")
harpoon:setup({
	settings = {
		save_on_toggle = false,
		sync_on_ui_close = false,
		save_on_change = true,
		key = function()
			return vim.loop.cwd()
		end,
	},
})

-- Telescope integration for Harpoon
local conf = require("telescope.config").values
local function toggle_harpoon_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end
	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

-- Harpoon keymaps
vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Add to Harpoon list" })
vim.keymap.set("n", "<leader>hv", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon Menu" })
vim.keymap.set("n", "<leader>hs", function()
	toggle_harpoon_telescope(harpoon:list())
end, { desc = "Search in Harpoon List" })
vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end, { desc = "Select 1st Harpoon file" })
vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end, { desc = "Select 2nd Harpoon file" })
vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end, { desc = "Select 3rd Harpoon file" })
vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end, { desc = "Select 4th Harpoon file" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hh", function()
	harpoon:list():prev()
end, { desc = "Previous Harpoon buffer" })
vim.keymap.set("n", "<leader>hl", function()
	harpoon:list():next()
end, { desc = "Next Harpoon buffer" })
