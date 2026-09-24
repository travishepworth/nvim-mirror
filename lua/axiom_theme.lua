-- Follows the axiom (quickshell) theme. axiom's scripts/theme_nvim.sh writes
-- the active theme to $XDG_STATE_HOME/axiom/nvim-theme.json and calls
-- reload() in every running instance over RPC.
local M = {}

M.path = (vim.env.XDG_STATE_HOME or (vim.env.HOME .. "/.local/state")) .. "/axiom/nvim-theme.json"

-- Colorscheme when there's no axiom theme file
M.fallback = { plugin = "tokyonight.nvim", colorscheme = "tokyonight-storm" }

-- axiom theme file stem -> native colorscheme; anything else (pywal themes,
-- submarine-sonar, ...) is built from the palette by mini.base16
M.map = {
  ["catppuccin-latte"] = { plugin = "catppuccin", colorscheme = "catppuccin-latte" },
  ["catppuccin-mocha"] = { plugin = "catppuccin", colorscheme = "catppuccin-mocha" },
  ["gruvbox-dark"] = { plugin = "gruvbox.nvim", colorscheme = "gruvbox" },
  ["gruvbox-light"] = { plugin = "gruvbox.nvim", colorscheme = "gruvbox" },
  ["solarized-dark"] = { plugin = "solarized.nvim", colorscheme = "solarized" },
  ["solarized-light"] = { plugin = "solarized.nvim", colorscheme = "solarized" },
  ["tokyo-night"] = { plugin = "tokyonight.nvim", colorscheme = "tokyonight-night" },
  ["tokyo-day"] = { plugin = "tokyonight.nvim", colorscheme = "tokyonight-day" },
}

local function read_theme()
  local fd = io.open(M.path, "r")
  if not fd then
    return nil
  end
  local ok, theme = pcall(vim.json.decode, fd:read("*a"))
  fd:close()
  if ok and type(theme) == "table" then
    return theme
  end
end

local function apply_native(scheme)
  pcall(function()
    require("lazy").load({ plugins = { scheme.plugin } })
  end)
  return pcall(vim.cmd.colorscheme, scheme.colorscheme)
end

local function apply_base16(theme)
  local ok = pcall(function()
    require("mini.base16").setup({ palette = theme.colors, use_cterm = true })
  end)
  if not ok then
    return false
  end
  vim.g.colors_name = "axiom-" .. theme.stem
  -- mini.base16 doesn't fire ColorScheme itself; lualine ('auto') etc. listen for it
  vim.api.nvim_exec_autocmds("ColorScheme", { pattern = vim.g.colors_name })
  return true
end

function M.reload()
  local theme = read_theme()
  if not theme then
    apply_native(M.fallback)
    return
  end
  vim.o.background = theme.variant == "light" and "light" or "dark"
  local scheme = M.map[theme.stem]
  if scheme and apply_native(scheme) then
    return
  end
  if not apply_base16(theme) then
    apply_native(M.fallback)
  end
end

return M
