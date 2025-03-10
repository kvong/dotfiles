--"  _   _                 _            
--" | \ | | ___  _____   _(_)_ __ ___   
--" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \  
--" | |\  |  __/ (_) \ V /| | | | | | | 
--" |_| \_|\___|\___/ \_/ |_|_| |_| |_| 
--"                                     
--" ----------------------------------------------------- 

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})

require("vim-options")
require("workflows")
require("keymaps")

-- Setup lazy.nvim
require("lazy").setup("plugins")
