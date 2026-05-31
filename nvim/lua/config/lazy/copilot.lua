return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
        cmd = "Copilot",
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = { "github/copilot.vim", "nvim-lua/plenary.nvim" },
        cmd = { "CopilotChat", "CopilotChatToggle" },
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>", mode = "v", desc = "Copilot Chat" },
        },
        opts = {},
    },
}
