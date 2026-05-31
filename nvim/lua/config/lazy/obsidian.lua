return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Crypta",
                path = "~/Crypta",
            },
        },
        completion = {
            nvim_cmp = false,
            blink = true,
        },
        ui = {
            enable = true,
        },
    },
}
