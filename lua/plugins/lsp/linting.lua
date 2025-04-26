return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- javascript = { "biome" },
			-- javascriptreact = { "biome" },
			-- typescriptreact = { "biome" },
			ejs = { "eslint_d" },
			svelte = { "eslint_d" },
			-- python = { "flake8", "mypy" },
			-- ruby = { "rubocop" },
			shell = { "shellcheck" },
      json = {"jsonlint"},
      yaml = {"yamllint"},
      dockerfile = {"hadolint"},
      -- c = {"cpplint"},
      -- cpp = {"cpplint"}
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })
	end,
}
