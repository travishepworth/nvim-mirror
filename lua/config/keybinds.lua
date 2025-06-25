-- Default Option table
local opts = { noremap = true, silent = true }

-- Shorten the function name
local keymap = vim.keymap.set

-- For Keybind Declarations
local wk = require("which-key")

-- Map space as the leader key
-- NOTE: Also mapped in lazy.lua to allow me to change which key in this file
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Resize window with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
keymap("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Splitting windows
keymap("n", "<leader>sv", "<C-w>v", vim.tbl_extend("keep", opts, { desc = "Vertical Split" }))
keymap("n", "<leader>sh", "<C-w>s", vim.tbl_extend("keep", opts, { desc = "Horizontal Split" }))
keymap("n", "<leader>se", "<C-w>=", vim.tbl_extend("keep", opts, { desc = "Equal Splits" }))
keymap("n", "<leader>sx", "<cmd>close<CR>", vim.tbl_extend("keep", opts, { desc = "Close Split" }))

-- Showing line numbers
keymap("n", "<leader>nn", "<cmd>set nu!<CR>", vim.tbl_extend("keep", opts, { desc = "Show Line Numbers" }))
keymap("n", "<leader>nr", ":set rnu!<CR>", vim.tbl_extend("keep", opts, { desc = "Show Relative Numbers" }))

-- Use JK in insert/terminal mode to trigger Escape
keymap("i", "jk", "<Esc>", vim.tbl_extend("keep", opts, { desc = "" }))
-- keymap("t", "jk", "<C-\\><C-n><Cmd>ToggleTerm<CR>", {noremap = true, silent = true, desc = ""})

-- Clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", vim.tbl_extend("keep", opts, { desc = "Clear Highlights" }))

-----------------------------
--  */ -- bufferline -- /*
-----------------------------

-- Move to previous / next
keymap("n", "<tab>", "<Cmd>BufferLineCycleNext<CR>", vim.tbl_extend("keep", opts, { desc = "" }))
keymap("n", "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", vim.tbl_extend("keep", opts, { desc = "" }))

-- Select Tab
keymap("n", "<leader>p", "<Cmd>BufferLinePick<CR>", vim.tbl_extend("keep", opts, { desc = "Pick Tab" }))

-- Pin Tab
keymap("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", vim.tbl_extend("keep", opts, { desc = "Pin Tab" }))

-- Close buffer
keymap("n", "<leader>bx", ":bp | bd! #<CR>", vim.tbl_extend("keep", opts, { desc = "Close Buffer" }))

-----------------------------
--  */ -- Telescope -- /*
-----------------------------

local builtin = require("telescope.builtin")
keymap("n", "<leader>ff", builtin.find_files, vim.tbl_extend("keep", opts, { desc = "Find Files" }))
keymap("n", "<leader>fg", builtin.live_grep, vim.tbl_extend("keep", opts, { desc = "Grep Files" }))
keymap("n", "<leader>fb", ":Telescope buffers<CR>", vim.tbl_extend("keep", opts, { desc = "Find Buffers" }))
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", vim.tbl_extend("keep", opts, { desc = "Find Help Tags" }))

-----------------------------
---  */ -- Copilot -- /*
-----------------------------

local function copilotToggle()
  local is_enabled = vim.fn['copilot#Enabled']() == 1

  if is_enabled then
    vim.cmd("Copilot disable")
    print("Copilot disabled")
  else
    vim.cmd("Copilot enable")
    print("Copilot enabled")
  end
end

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-\\>", "copilot#Dismiss()", { expr = true, silent = true })
vim.keymap.set("n", "<leader>ct", copilotToggle, { desc = "Toggle Copilot" })

-----------------------------
--  */ -- Markdown -- /*
-----------------------------

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", vim.tbl_extend("keep", opts, { desc = "Toggle Markview" }))
vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<CR>", vim.tbl_extend("keep", opts, { desc = "Toggle Markview" }))

-----------------------------
--  */ -- neo-tree -- /*
-----------------------------

-- Opening Neotree to the left / Close it with q
keymap("n", "<leader>e", ":Neotree filesystem reveal left<CR>", vim.tbl_extend("keep", opts, { desc = "Open Neotree" }))

-----------------------------
--  */ -- Aerial -- /*
-----------------------------

-- Toggle Aerial to the right, and bring the cursor in.
keymap("n", "<leader>r", "<cmd>AerialToggle! right<CR>", vim.tbl_extend("keep", opts, { desc = "Open Aerial" }))

-----------------------------
--  */ -- lsp-config -- /*
-----------------------------

keymap("n", "<leader>ck", vim.lsp.buf.hover, vim.tbl_extend("keep", opts, { desc = "Hover" }))
keymap("n", "<leader>cd", vim.lsp.buf.definition, vim.tbl_extend("keep", opts, { desc = "Definition" }))
keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("keep", opts, { desc = "Code Actions" }))
keymap("n", "<leader>cr", vim.lsp.buf.references, vim.tbl_extend("keep", opts, { desc = "References" }))
keymap("n", "<leader>ce", vim.lsp.buf.rename, vim.tbl_extend("keep", opts, { desc = "Refactor" }))

-----------------------------
--  */ -- terminal -- /*
-----------------------------

keymap("t", "<S-Tab>", "<C-\\><C-n>", vim.tbl_extend("keep", opts, { desc = "" }))
keymap("n", "<leader>te", "<Cmd>ToggleTerm<CR>", vim.tbl_extend("keep", opts, { desc = "Toggle Bottom Terminal" }))
keymap("n", "<leader>tr", "<Cmd>lua RightTerm_toggle()<CR>", vim.tbl_extend("keep", opts, { desc = "Toggle Right Terminal" }))
keymap("n", "<leader>gt", "<Cmd>lua Lazygit_toggle()<CR>", vim.tbl_extend("keep", opts, { desc = "Open Git" }))

-----------------------------
-- */ -- Register Names for whichkey -- /*
-----------------------------

wk.add({
  { "<leader>b", group = "Buffers" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>n", group = "Line Numbers" },
  { "<leader>s", group = "Splits" },
  { "<leader>x", group = "Trouble" },
  { "<leader>c", group = "LSP", mode = { "n", "v" } },
})
