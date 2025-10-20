
-- Auto-initialize molten for supported file types using FileType event
-- This is more reliable than BufEnter for detecting file type changes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python", "notebook", "quarto", "markdown", "rmarkdown"},
  callback = function()
    -- Only initialize if not already done for this buffer
    if not vim.b.molten_initialized then
      local success = pcall(vim.cmd, "MoltenInit")
      if success then
        vim.b.molten_initialized = true
      end
    end
  end,
})

-- Initialization / Kernel Selection
local wk = require("which-key")
local runner = require("quarto.runner")
local quarto = require("quarto")

-- Helper function to create kernel from uv/pip environment
local function create_kernel()
  vim.cmd("MoltenSelectKernel")
end

wk.add({
	{ "<leader>j", group = "jupyter", icon = { icon = "", color = "blue" } },

	{ "<leader>jA", runner.run_all, desc = "All Cells" },
	{ "<leader>ja", runner.run_above, desc = "Cell and Above" },
	{ "<leader>jc", runner.run_cell, desc = "Cell" },
	{ "<leader>jl", runner.run_line, desc = "Line" },

	{ "<leader>jp", quarto.quartoPreview, desc = "Open Preview" },
	{ "<leader>jq", quarto.quartoClosePreview, desc = "Close Preview" },

	{ "<leader>jd", ":MoltenLoad<cr>", desc = "Load Molten State" },
	{ "<leader>jk", create_kernel, desc = "Select Kernel" },
	{ "<leader>js", ":MoltenSave<cr>", desc = "Save Molten State" },
	{ "<leader>ji", ":MoltenInit<cr>", desc = "Init Molten" },
	{ "<leader>jD", ":MoltenDeinit<cr>", desc = "Deinit Molten" },
	{ "<leader>jI", ":MoltenImagePopup<cr>", desc = "Show Image" },
	{ "<leader>jo", ":MoltenShowOutput<cr>", desc = "Show Output" },
	{ "<leader>jv", "<cmd>VenvSelect<cr>", desc = "Select LSP Env" },
})





-- vim.api.nvim_create_user_command('SetupNotebookEnvironment', function(opts)
-- 	local project_name = opts.args

-- 	if project_name == "" then
-- 	  vim.notify("Error: Please provide a project name", vim.log.levels.ERROR)
-- 	  return
-- 	end

-- 	local cwd = vim.fn.getcwd()
-- 	local venv_path = cwd .. "/.venv"

-- 	-- Check if venv already exists
-- 	if vim.fn.isdirectory(venv_path) == 1 then
-- 	  local response = vim.fn.input("Virtual environment already exists. Recreate? (y/n): ")
-- 	  if response:lower() ~= "y" then
-- 		vim.notify("Cancelled", vim.log.levels.INFO)
-- 		return
-- 	  end
-- 	  vim.fn.system("rm -rf " .. venv_path)
-- 	end

-- 	vim.notify("Setting up notebook environment for: " .. project_name, vim.log.levels.INFO)

-- 	local cmd = string.format([[
-- 	  cd %s &&
-- 	  echo "Creating virtual environment..." &&
-- 	  uv venv %s &&
-- 	  echo "Installing ipykernel..." &&
-- 	  %s/bin/python -m pip install --upgrade pip &&
-- 	  %s/bin/python -m pip install ipykernel &&
-- 	  ([ -f requirements.txt ] && echo "Installing requirements..." && %s/bin/python -m pip install -r requirements.txt || echo "No requirements.txt found, skipping...") &&
-- 	  echo "Registering Jupyter kernel..." &&
-- 	  %s/bin/python -m ipykernel install --user --name %s &&
-- 	  echo "" &&
-- 	  echo "✓ Setup complete!" &&
-- 	  echo "  Virtual env: %s" &&
-- 	  echo "  Kernel name: %s" &&
-- 	  echo "" &&
-- 	  echo "To activate: source %s/bin/activate" &&
-- 	  echo "To use in Molten: :MoltenInit %s"
-- 	]], cwd, venv_path, venv_path, venv_path, venv_path, venv_path, project_name, venv_path, project_name, venv_path, project_name)

-- 	-- Run the setup command
-- 	vim.fn.system(cmd)

--   end, {
-- 	nargs = 1,
-- 	complete = function()
-- 	  -- Auto-complete with current directory name
-- 	  return { vim.fn.fnamemodify(vim.fn.getcwd(), ':t') }
-- 	end,
-- 	desc = "Setup uv venv and jupyter kernel for notebook environment"
--   })

-- -- Function to create kernel from conda environment
-- function create_kernel_from_conda()
--   vim.cmd("MoltenSelectKernel")
-- end



