return {
    "lewis6991/gitsigns.nvim",
    opts = {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = function(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            map("n", "gn", gs.next_hunk, "Next hunk")
            map("n", "gN", gs.prev_hunk, "Prev hunk")
            map("n", "gp", gs.preview_hunk, "Preview hunk")
            map("n", "gs", gs.stage_hunk, "Stage hunk")
            map("n", "gu", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>hb", gs.blame_line, "Blame line")
        end,
    },
}
