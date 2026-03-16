return {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { -- only load the plugin on these keymaps
        { "<leader>b",      ":Neotree toggle <CR>" },
        { "<leader>nb", ":Neotree buffers reveal float<CR>" },
    },
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            source_selector = {
                winbar = false,
                statusline = false,
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        -- '.git',
                        -- '.DS_Store',
                        -- 'thumbs.db',
                    },
                    never_show = {},
                },
            },
            window = {
                width = 28,
                position = "right",
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        -- auto close neo-tree after opening file
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },
        })
    end,
}
