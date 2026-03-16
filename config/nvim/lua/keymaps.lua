local map = vim.keymap.set
vim.g.mapleader = " "

-- Save current file
map("n", "<leader>w", ":w<cr>", { desc = "Save file", remap = true })

-- move line
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- ESC pressing jk
map("i", "jk", "<ESC>", { desc = "jk to esc", noremap = true })

-- ESC pressing JK
map("i", "jk", "<ESC>", { desc = "JK to esc", noremap = true })

-- Quit Neovim
map("n", "<leader>q", ":q<cr>", { desc = "Quit Neovim", remap = true })

-- Increment/decrement
map("n", "+", "<C-a>", { desc = "Increment numbers", noremap = true })
map("n", "-", "<C-x>", { desc = "Decrement numbers", noremap = true })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all", noremap = true })

-- Indenting
map("v", "<", "<gv", { desc = "Indenting", silent = true, noremap = true })
map("v", ">", ">gv", { desc = "Indenting", silent = true, noremap = true })

-- New tab
map("n", "te", ":tabedit")

-- Split window
map("n", "<leader>sh", ":split<Return><C-w>w", { desc = "splits horizontal", noremap = true })
map("n", "<leader>sv", ":vsplit<Return><C-w>w", { desc = "Split vertical", noremap = true })

-- Navigate vim panes better
map("n", "<C-k>", "<C-w>k", { desc = "Navigate up" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate down" })
map("n", "<C-h>", "<C-w>h", { desc = "Navigate left" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate right" })

-- Change 2 split windows from vertical to horizontal or vice versa
map("n", "<leader>th", "<C-w>t<C-w>H", { desc = "Change window splits to horizontal", noremap = true})
map("n", "<leader>tk", "<C-w>t<C-w>K", { desc = "Change window splits to vertical", noremap = true})

-- Resize window
map("n", "<C-Up>", ":resize -3<CR>")
map("n", "<C-Down>", ":resize +3<CR>")
map("n", "<C-Left>", ":vertical resize -3<CR>")
map("n", "<C-Right>", ":vertical resize +3<CR>")

-- Bufferline
map("n", "<Tab>", ":bnext<cr>", { desc = "Move to next tab", noremap = true })
map("n", "<S-Tab>", ":bprevious<cr>", { desc = "Move to previous tab", noremap = true })
map("n", "<leader>x", ":bd<cr>", { desc = "Buffer close", noremap = true })

-- Move buffer to left
map("n", "<leader>mi", ":BufferLineMovePrev<CR>", { desc = "Move buffer to the left", noremap = true })

-- Move buffer to right
map("n", "<leader>md", ":BufferLineMoveNext<CR>", { desc = "Move buffer to the right", noremap = true })

map("n", "<leader>f", "<cmd>Neotree focus<CR>", { desc = "Focus on the file being edited", noremap = true })

-- Comments
map({"n", "v"}, "<leader>co", ":CommentToggle<cr>", { desc = "CommentToggle", noremap = true })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find_files", noremap = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live_grep", noremap = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Telescope oldfiles", noremap = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers", noremap = true })
vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>', { desc = "LSP Definitions" })

-- Spectre
map('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre", noremap = true })
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Spectre Search current word", noremap = true })
map('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word", noremap = true })
map('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file", noremap = true})

-- Move one line down with Alt + j
vim.api.nvim_set_keymap('n', '<A-j>', ':m+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move one line up with Alt + k
vim.api.nvim_set_keymap('n', '<A-k>', ':m-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Move the current line down with Shift + o and return to normal mode
-- vim.api.nvim_set_keymap('i', '<S-o>', '<Esc>o<Esc>', { noremap = true, silent = true })

-- Map dd to delete without copying to the registry
vim.keymap.set("n", "dd", '"_dd')

-- Map x to delete a character without copying it to the register
vim.keymap.set("n", "x", '"_x')

-- Map d to delete any selection without copying to the record
vim.keymap.set("n", "d", '"_d')

-- Select all content with space + a in normal mode
vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', { noremap = true, silent = true })

-- Map f to $ to go to the end of the line
vim.api.nvim_set_keymap('n', 'f', '$', { noremap = true, silent = true })

-- delete highlighting
vim.api.nvim_set_keymap('n', '<Space>2', ':noh<CR>', { noremap = true, silent = true })
