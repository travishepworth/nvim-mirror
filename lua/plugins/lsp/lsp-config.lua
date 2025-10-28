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

      -- Define custom configurations for specific language servers
      -- This table will be used to override default settings
      local configs = {
        lua_ls = {
        },
        ts_ls = {
          filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
          cmd = { "typescript-language-server", "--stdio" },
        },
        gopls = {
          cmd = { "gopls", "serve" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_markers = {"go.work", "go.mod", "Dockerfile", ".git"},
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
          cmd = { "qmlls6" },
          -- root_markers = { ".git" },
          root_dir = function(fname)
            local qml_root = vim.lsp.config.root_pattern(
              "shell.qml",
              "*.qmlproject",  -- Qt Creator QML project files
              "qmldir",        -- QML module definition files
              "CMakeLists.txt" -- CMake projects with QML
            )(fname)
            if qml_root then
              return qml_root
            end
            return vim.lsp.config.root_pattern(".git")(fname)
                or vim.lsp.config.path.dirname(fname)
          end,
          single_file_support = true,
          filetypes = { "qml", "qmljs" },
          autostart = true,
          init_options = {
            format = {
              indent_size = 2,
            },
          },
          on_attach = function(client, bufnr)
            local clients = vim.lsp.get_clients({ name = "qmlls", bufnr = bufnr })
            if #clients > 1 then
              for i = 2, #clients do
                clients[i].stop()
              end
            end
          end,
          flags = {
            debounce_text_changes = 150,
            exit_timeout = false,
          },
        },
        cmake = {
          filetypes = { "cmake" },
          root_markers = { "CMakeLists.txt", ".git" },
        },
        clangd = {
          filetypes = { "c", "cpp" },
          root_markers = { "CMakeLists.txt", ".git", "meson.build", "Makefile" },
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
        -- Anything not in the table gets default
      }

      -- Loop through the servers managed by mason-lspconfig and set them up
      local servers_to_setup = require("mason-lspconfig").get_installed_servers()

      for _, server_name in ipairs(servers_to_setup) do
        -- Get custom config if it exists, otherwise use an empty table
        local server_config = configs[server_name] or {}
        -- Ensure capabilities are always included
        server_config.capabilities = capabilities
      end
    end,
  },
}
