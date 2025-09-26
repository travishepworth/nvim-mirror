return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local servers = {
        "lua_ls",
        "pylsp",
        "bashls",
        "jsonls",
        "cmake",
        "gitlab_ci_ls",
        "gh_actions_ls",
        "gopls",
        -- "nil_ls",
        "qmlls",
        "ts_ls",
        "clangd",
        -- "prosemd_lsp",
        -- "spectral",
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        auto_install = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Set border for LSP UI windows
      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }

      -- Get default LSP capabilities from cmp_nvim_lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Define custom configurations for specific language servers
      -- This table will be used to override default settings
      local configs = {
        lua_ls = {
          -- Note: lua_ls setup is often more detailed, but we'll stick to the user's original for now.
          -- Example: settings = { Lua = { ... } }
        },
        ts_ls = {
          filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
          cmd = { "typescript-language-server", "--stdio" },
        },
        gopls = {
          cmd = { "gopls", "serve" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = lspconfig.util.root_pattern("go.work", "go.mod", "Dockerfile", ".git"),
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
        },
        qmlls = {
          -- Fix 1: More specific root_dir pattern to prevent multiple instances
          cmd = { "qmlls6" },
          root_dir = function(fname)
            -- First try to find a QML-specific project marker
            local qml_root = lspconfig.util.root_pattern(
              "*.qmlproject",  -- Qt Creator QML project files
              "qmldir",        -- QML module definition files
              "CMakeLists.txt" -- CMake projects with QML
            )(fname)

            if qml_root then
              return qml_root
            end

            -- Fallback to git root or current file directory
            return lspconfig.util.root_pattern(".git")(fname)
                or lspconfig.util.path.dirname(fname)
          end,

          -- Fix 2: Add single_file_support to handle standalone QML files better
          single_file_support = true,

          -- Fix 3: Explicitly set filetypes
          filetypes = { "qml", "qmljs" },

          -- Fix 4: Add autostart control
          autostart = true,

          init_options = {
            format = {
              indent_size = 2,
            },
          },

          -- Fix 5: Add on_attach to ensure proper cleanup
          on_attach = function(client, bufnr)
            -- Check if there's already a qmlls client attached to this buffer
            -- Using vim.lsp.get_clients() for Neovim 0.10+
            local clients = vim.lsp.get_clients({ name = "qmlls", bufnr = bufnr })
            if #clients > 1 then
              -- Keep only the first client, stop others
              for i = 2, #clients do
                clients[i].stop()
              end
            end
          end,

          -- Fix 6: Add flags to control LSP behavior
          flags = {
            debounce_text_changes = 150, -- Debounce didChange notifications
            exit_timeout = false,        -- Don't wait for server exit
          },
        },
        -- solargraph = {
        -- 	diagnostics = false,
        -- },
        cmake = {
          filetypes = { "cmake" },
          root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
        },
        clangd = {
          filetypes = { "c", "cpp" },
          root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git", "meson.build", "Makefile"),
          cmd = {
            "clangd",
            "--compile-commands-dir=./build/",
            "--query-driver=/usr/bin/arm-none-eabi-*",
            "--background-index",
            "--header-insertion=iwyu",
            "--header-insertion-decorators=0",
            "--pch-storage=memory",
          },
        },
        -- Servers with no special config don't need to be in this table.
        -- e.g., pylsp, bashls, jsonls, nil_ls, gitlab_ci_ls, gh_actions_ls
      }

      -- Loop through the servers managed by mason-lspconfig and set them up
      local servers_to_setup = require("mason-lspconfig").get_installed_servers()

      for _, server_name in ipairs(servers_to_setup) do
        -- Get custom config if it exists, otherwise use an empty table
        local server_config = configs[server_name] or {}

        -- Ensure capabilities are always included
        server_config.capabilities = capabilities

        -- Call setup for the server with its specific configuration
        lspconfig[server_name].setup(server_config)
      end
    end,
  },
}
