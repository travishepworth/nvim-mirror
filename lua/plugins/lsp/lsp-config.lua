return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				auto_install = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
      require('lspconfig.ui.windows').default_options = {
        border = "rounded",
      }
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
				cmd = { "typescript-language-server", "--stdio" },
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
      lspconfig.nil_ls.setup({
        capabilities = capabilities,
      })
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
				diagnostics = false,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
      lspconfig.prosemd_lsp.setup({
        capabilities = capabilities,
      })
      lspconfig.gitlab_ci_ls.setup({
        capabilities = capabilities,
      })
      -- lspconfig.spectral.setup({
      --   capabilities = capabilities,
      --   filetypes = { "yaml", "yml" },
      -- })
			lspconfig.clangd.setup({
				capabilities = capabilities,
				filetypes = { "c", "cpp" },
				root_dir = lspconfig.util.root_pattern("CmakeLists.txt", ".git", "meson.build"),
				cmd = {
					"clangd",
          -- "--compile-commands-dir=/home/travis/repos/travyboard/firmware/build/",
          "--compile-commands-dir=./build/",
          "--query-driver=/usr/bin/arm-none-eabi-g++,/usr/bin/arm-none-eabi-gcc",
					"--background-index",
					"--header-insertion=iwyu",
					"--header-insertion-decorators=0",
					"--pch-storage=memory",
				},
			})
		end,
	},
}
