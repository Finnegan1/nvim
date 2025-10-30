
-- Auto-initialize molten for supported file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"notebook", "quarto", "markdown", "rmarkdown"},
	callback = function()
		if not vim.b.molten_initialized then
			vim.defer_fn(function()
				local success = pcall(vim.cmd, "MoltenInit")
				if success then
					vim.b.molten_initialized = true
					-- Activate quarto runner
					local ok, quarto_runner = pcall(require, "quarto.runner")
					if ok and quarto_runner.activate then
						pcall(quarto_runner.activate, "molten")
					end
				end
			end, 100)
		end
	end,
})

local runner = require("quarto.runner")
local quarto = require("quarto")

local function create_kernel()
	vim.cmd("MoltenSelectKernel")
end

local function init_molten_runner()
	vim.cmd("MoltenInit")
	vim.b.molten_initialized = true
	local ok, quarto_runner = pcall(require, "quarto.runner")
	if ok and quarto_runner.activate then
		quarto_runner.activate("molten")
		vim.notify("Molten initialized and quarto runner activated", vim.log.levels.INFO)
	else
		vim.notify("Molten initialized but quarto runner activation failed", vim.log.levels.WARN)
	end
end

vim.api.nvim_create_user_command("QuartoMoltenInit", init_molten_runner, {
	desc = "Initialize Molten and activate Quarto runner"
})

-- Keymaps
vim.keymap.set("n", "<leader>jA", runner.run_all, { desc = "Run all cells" })
vim.keymap.set("n", "<leader>ja", runner.run_above, { desc = "Run cell and above" })
vim.keymap.set("n", "<leader>jc", runner.run_cell, { desc = "Run cell" })
vim.keymap.set("n", "<leader>jl", runner.run_line, { desc = "Run line" })

vim.keymap.set("n", "<leader>jp", quarto.quartoPreview, { desc = "Open Preview" })
vim.keymap.set("n", "<leader>jq", quarto.quartoClosePreview, { desc = "Close Preview" })

vim.keymap.set("n", "<leader>jd", "<cmd>MoltenLoad<cr>", { desc = "Load Molten State" })
vim.keymap.set("n", "<leader>jk", create_kernel, { desc = "Select Kernel" })
vim.keymap.set("n", "<leader>js", "<cmd>MoltenSave<cr>", { desc = "Save Molten State" })
vim.keymap.set("n", "<leader>ji", init_molten_runner, { desc = "Init Molten + Quarto" })
vim.keymap.set("n", "<leader>jD", "<cmd>MoltenDeinit<cr>", { desc = "Deinit Molten" })
vim.keymap.set("n", "<leader>jI", "<cmd>MoltenImagePopup<cr>", { desc = "Show Image" })
vim.keymap.set("n", "<leader>jo", "<cmd>MoltenShowOutput<cr>", { desc = "Show Output" })
vim.keymap.set("n", "<leader>jv", "<cmd>VenvSelect<cr>", { desc = "Select LSP Env" })
