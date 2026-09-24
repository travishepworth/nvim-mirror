-- nvim-treesitter `main` branch (the old `master` branch is incompatible with nvim 0.12)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        -- Emulate `auto_install`: install missing parsers (requires the tree-sitter CLI)
        if not vim.treesitter.language.add(lang) then
          if vim.tbl_contains(ts.get_available(), lang) and vim.fn.executable("tree-sitter") == 1 then
            ts.install(lang)
          end
          return
        end

        vim.treesitter.start(args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
