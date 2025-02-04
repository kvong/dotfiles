return {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        -- available: devicons, mini, default is mini
        -- if provider not loaded and enabled is true, it will try to use another provider
        dashboard.section.header.val = {
                "                                     ",
                "           ▀████▀▄▄              ▄█  ",
                "           ▀████▀▄▄              ▄█  ",
                "             █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█  ",
                "     ▄        █          ▀▀▀▀▄  ▄▀   ",
                "    ▄▀ ▀▄      ▀▄              ▀▄▀   ",
                "   ▄▀    █     █▀   ▄█▀▄      ▄█     ",
                "   ▀▄     ▀▄  █     ▀██▀     ██▄█    ",
                "    ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █   ",
                "     █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀   ",
                "    █   █  █      ▄▄           ▄▀    ",
                "                                     ",
        }
        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
            dashboard.button("i", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("m", "  BookMarks", ":Telescope marks <CR>"),
            dashboard.button("d", "  Dotfiles", ":Telescope find_files search_dirs={\"~/dotfiles\"}<cr>"),
            dashboard.button("o", "  Obsidian", ":Telescope find_files search_dirs={\"~/vaults\"}<cr>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }
        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        dashboard.opts.opts.noautocmd = true
        require("alpha").setup(
            dashboard.opts
        )
    end,
}
