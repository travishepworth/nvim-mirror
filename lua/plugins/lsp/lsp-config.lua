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
        ensure_installed = {
          "lua_ls",
          -- "typescript-language-server",
          "pylsp",
          "bashls",
          -- "solargraph",
          "jsonls",
          "cmake",
          "clangd",
          "gitlab_ci_ls",
          "gh_actions_ls",
          -- "prosemd_lsp",
          -- "spectral",
        },
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
      lspconfig.qmlls.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("shell.qml", ".git"),
        init_options = {
          format = {
            indent_size = 2,
          },
        }
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
      lspconfig.cmake.setup({
        capabilities = capabilities,
        filetypes = { "cmake" },
        root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
      })
      -- lspconfig.prosemd_lsp.setup({
      --   capabilities = capabilities,
      -- })
      lspconfig.gitlab_ci_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.gh_actions_ls.setup({
        capabilities = capabilities,
      })
      -- lspconfig.spectral.setup({
      --   capabilities = capabilities,
      --   filetypes = { "yaml", "yml" },
      -- })
			lspconfig.clangd.setup({
				capabilities = capabilities,
				filetypes = { "c", "cpp" },
				root_dir = lspconfig.util.root_pattern("CmakeLists.txt", ".git", "meson.build", "Makefile"),
				-- cmd = {
				-- 	"clangd",
    --       "--compile-commands-dir=./build/",
    --       "--query-driver=/usr/bin/arm-none-eabi-gcc",
				-- 	"--background-index",
				-- 	"--header-insertion=iwyu",
				-- 	"--header-insertion-decorators=0",
				-- 	"--pch-storage=memory",
				-- },
        cmd = {
							"clangd",
							"--compile-commands-dir=./build/",
							"--background-index",
							"--header-insertion=iwyu",
							"--header-insertion-decorators=0",
							"--pch-storage=memory",
							"--clang-tidy",
          },
			})
		end,
	},
}
