local vim = vim
local g = vim.g

return {
	{
		"zbirenbaum/copilot.lua",
		enabled = true,
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				-- vim.g.copilot_nes_debounce = 500
			end,
		},
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
				nes = {
					enabled = false,
					auto_trigger = false,
					keymap = {
						-- accept_and_goto = "<c-c>",
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
	-- We use avante for Claude features and integrated development.
	-- Sidekick is used for Codex features and integrated development.
	-- This is because ChatGPT pro includes Codex integration but does not allow one to create API keys.
	-- Sidekick is also used for NES.
	{
		"folke/sidekick.nvim",
		enabled = false,
		opts = {
			cli = {
				nes = {
					enabled = false,
				},
				mux = {
					backend = "tmux",
					enabled = true,
				},
			},
		},
		keys = {
			{
				"<leader>sas",
				function()
					local provider = "codex"
					require("sidekick.cli").toggle({ name = provider, focus = true })
				end,
				desc = "Sidekick: Toggle CLI",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>sav",
				function()
					-- Send only the highlighted text so Sidekick runs the prompt on that slice.
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "Sidekick: Send Visual Selection",
			},
			{
				"<leader>sap",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "Sidekick: Select Prompt",
			},
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if require("sidekick").nes_jump_or_apply() then
						return -- jumped or applied
					end

					-- fall back to normal tab
					return "<tab>"
				end,
				mode = { "i", "n" },
				expr = true,
				desc = "Sidekick: Goto/Apply Next Edit Suggestion",
			},
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		config = function()
			local provider = os.getenv("AVANTE_ANTHROPIC_API_KEY") and "claude" or "copilot"

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
						model = "claude-sonnet-4-5-20250929",
						extra_request_body = {
							max_tokens = 20480, -- Default is 20480
						},
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
