return { 
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' } -- incase this fails, navigate to ~/.local/share/nvim/lazy/telescope-fzf-native.nvim and run 'make' to create the object file
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
            local pickers = require('telescope.pickers')
            local finders = require('telescope.finders')
            local conf = require('telescope.config').values

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', function()
              pickers.new({}, {
                prompt_title = ' Files & Content ',
                finder = finders.new_dynamic({
                  fn = function(prompt)
                    if not prompt or prompt == '' then return {} end
                    local results = {}
                    -- Split on double-space to separate grep query from filename filter
                    -- e.g. "hello  main.py" → grep for "hello", search files for "main.py"
                    local grep_query, file_query = prompt:match('^(.-)  (.-)$')
                    if not grep_query then
                      grep_query = prompt
                      file_query = nil
                    end
                    -- Content search via rg (uses grep_query or full prompt)
                    local ok, rg_out = pcall(function()
                      return vim.fn.systemlist({'rg', '--no-heading', '--line-number', '--column', '--smart-case', '--max-columns', '300', '--', grep_query})
                    end)
                    if ok and type(rg_out) == 'table' then
                      for _, line in ipairs(rg_out) do
                        if line ~= '' then
                          local file, lnum, col, text =
                            line:match('^(.+):(%d+):(%d+):(.*)$')
                          if file then
                            table.insert(results, {
                              filename = file,
                              lnum = tonumber(lnum),
                              col = tonumber(col),
                              text = text,
                              display = line,
                            })
                          end
                        end
                      end
                    end
                    -- File name search via fd (uses file_query if present, else full prompt)
                    local fd_query = file_query or prompt
                    if vim.fn.executable('fd') == 1 then
                      local ok, fd_out = pcall(function()
                        return vim.fn.systemlist({'fd', '--type', 'f', '--color', 'never', '-E', '.git', fd_query})
                      end)
                      if ok and type(fd_out) == 'table' then
                        for _, file in ipairs(fd_out) do
                          if file ~= '' then
                            table.insert(results, {
                              filename = file, lnum = 1, col = 0,
                              text = file,
                              display = '[F] ' .. file,
                            })
                          end
                        end
                      end
                    end
                    return results
                  end,
                  entry_maker = function(entry)
                    return {
                      value = entry.filename,
                      display = entry.display,
                      ordinal = (entry.display or entry.text or entry.filename),
                      filename = entry.filename,
                      lnum = entry.lnum or 1,
                      col = entry.col or 0,
                    }
                  end,
                }),
                sorter = conf.generic_sorter({}),
                previewer = conf.grep_previewer({}),
              }):find()
            end, {})
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
