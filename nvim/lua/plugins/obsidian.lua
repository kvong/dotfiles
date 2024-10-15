return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.opt.conceallevel = 1
        local conf = {
            workspaces = {
                {
                  name = "personal",
                  path = "~/vault/personal",
                },
                {
                  name = "work",
                  path = "~/vault/work",
                },
            }      
        }
        require("obsidian").setup( conf )
    end
}
