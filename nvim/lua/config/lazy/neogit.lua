return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim", -- richer diffs with :DiffviewOpen
    },
    config = function()
        require("neogit").setup({
            mappings = {
                status = {
                    ["gs"] = "VSplitOpen",
                    ["gn"] = "GoToNextHunkHeader",
                    ["gN"] = "GoToPreviousHunkHeader",
                },
            },
        })
        vim.keymap.set("n", "<leader>ng", function()
            require("neogit").open()
        end, { desc = "Neogit status" })
    end,
}
-- Usage:
--   <leader>ng   open Neogit status
--   s / u        stage / unstage file or hunk (cursor on it)
--   TAB          expand file to show hunks inline
--   c c          commit (opens commit message buffer, :wq to confirm)
--   P p          push to upstream
--   F p          pull from upstream
--   b b          checkout branch, b n = new branch
--   q            close Neogit
