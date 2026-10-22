return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
        config = function() 
            require("harpoon").setup({})
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<C-u>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-i>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-o>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-p>", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "<C-a>", function() harpoon:list():clear() end)
        end
    },
}
