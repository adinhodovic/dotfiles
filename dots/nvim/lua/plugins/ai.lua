local vim = vim
local g = vim.g

return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<c-c>",
						accept_word = false,
						accept_line = false,
						next = false,
						prev = false,
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = true,
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		config = function()
			local provider = os.getenv("ANTHROPIC_API_KEY") and "claude" or "copilot"
			local aiOpts = {
				provider = provider, -- "claude" or "copilot"
				auto_suggestions_provider = provider,
				behaviour = {
					auto_suggestions = false,
				},
				file_selector = {
					provider = "fzf",
				},
				providers = {
					claude = {
						model = "claude-sonnet-4-20250514",
					},
					copilot = {
						model = "gpt-5",
					},
				},
				input = {
					provider = "snacks",
					provider_opts = {
						-- Snacks input configuration
						title = "Avante Input",
					},
				},
				web_search_engine = {
					provider = "tavily",
				},
			}
			local function read_system_prompt(filepath)
				local lines = vim.fn.readfile(filepath)
				return table.concat(lines, "\n")
			end
			-- https://gist.github.com/burkeholland/88af0249c4b6aff3820bf37898c8bacf
			local system_prompt_path = vim.fn.expand("~/dotfiles/dots/nvim/assets/chatgpt-prompt.txt")
			local system_prompt = read_system_prompt(system_prompt_path)

			if provider == "copilot" then
				aiOpts.system_prompt = system_prompt
			end

			require("avante").setup(aiOpts)
		end,
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"folke/snacks.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
		},
	},
}
