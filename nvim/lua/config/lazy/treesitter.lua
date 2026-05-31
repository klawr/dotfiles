return {
        -- cloak might be neat to hide stuff

        -- cooler syntax highlighting
        -- is kind of part of nvim already?
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
                require('nvim-treesitter.configs').setup({
                        ensure_installed = {"vimdoc", "c", "lua", "rust"},
                        sync_install = false,
                        auto_install = true,
                        indent = {
                                enable = true
                        },
                        highlight = {
                                enable = true,
                                additional_vim_regex_highlighting = { "markdown" },
                        },
                })
        end
}
