return {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },  -- Load Git Fugitive lazily on Git commands
    config = function()
        -- Any Fugitive-specific config can go here
        -- Example: you can set custom key mappings for Git commands
    end,
}
