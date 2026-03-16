local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("keymaps")
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- loads all plugins in plugins/
  },
  defaults = {
    lazy = false, -- plugins are not lazy loaded by default
  },
})

vim.wo.number = true
vim.wo.relativenumber = false
-- -- -- Configuración para usar espacios en lugar de tabulaciones
-- vim.opt.expandtab = true          -- Converts the tab key to spaces
-- vim.opt.tabstop = 2               -- Number of spaces that a tab represents
-- vim.opt.shiftwidth = 2            -- Number of spaces when using >> and <<
-- vim.opt.softtabstop = 2           -- Number of spaces when pressing Tab in insert mode
-- --
vim.api.nvim_set_keymap('n', '<F2>', ':nohlsearch<CR>', { noremap = true, silent = true })

vim.opt.colorcolumn = ""


-- Function to toggle between 'relativenumber' and 'number'
function ToggleNumber()
    if vim.wo.relativenumber then
        -- If relative numbering is enabled, disable it and use simple numbering.
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        -- If relative numbering is disabled, enable it
        vim.wo.relativenumber = true
        vim.wo.number = true
    end
end

-- Key mapping to toggle between simple and relative numbering
-- Using <leader>' as a key combination
vim.api.nvim_set_keymap('n', "<leader>'", ':lua ToggleNumber()<CR>', { noremap = true, silent = true })

-- Debug init.lua usage
vim.cmd("echo 'Neovim config loaded!'")
