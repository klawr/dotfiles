return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "omnisharp",
                "ts_ls",
                "eslint",
                "svelte",
                "pyright",
                "rust_analyzer",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = require("blink.cmp").get_lsp_capabilities(),
                    })
                end,
            }
        })

        vim.lsp.config("svelte", {
            cmd = { "~/.cargo/bin/lspdock", "--stdio" },
        })
    end
}
