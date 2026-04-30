return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = { "bashls", "lua_ls", "cssls", "clangd"},
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = { "bashls", "cssls", "lua_ls", "clangd" }
            for _, server in ipairs(servers) do
                -- La nueva API nativa en Neovim v0.11+
                vim.lsp.config(server, { capabilities = capabilities })
                vim.lsp.enable(server)
            end

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Definitions" })
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format your code" })
        end,
    },
}
