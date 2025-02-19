return { 
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
        },
        config = function ()
            require('telescope').setup{
                pickers = {
                    find_files = {
                        theme = "ivy"
                    },
                    buffers = {
                        theme = "ivy"
                    },
                    live_grep = {
                        theme = "ivy"
                    },
                },
                extensions = {
                    fzf = {}
                }
            }

            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fm', builtin.marks, {})
            vim.keymap.set('n', '<leader>df', function ()
                builtin.find_files {
                    search_dirs = {'~/dotfiles'},
                    recurse = true,
                }
            end)
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function ()
            -- This is your opts table
            require("telescope").setup {
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                  }
                }
              }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
