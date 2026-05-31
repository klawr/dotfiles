return {
    "nvim-telescope/telescope.nvim",
dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                },
            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                },
            },
        })
        require("telescope").load_extension("file_browser")
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fb", require("telescope").extensions.file_browser.file_browser, {})
        vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fs", builtin.git_status, {})
        vim.keymap.set("n", "<leader>giw", function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end)
        vim.keymap.set("n", "<leader>gaw", function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end)
        vim.keymap.set("n", "<leader>gg", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end
}
