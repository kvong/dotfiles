return {
    'gsuuon/model.nvim',
    config = function() 
    local openai = require('model.providers.openai')

    -- configure default model params here for the provider
    openai.initialize({
        model = 'gpt-4o',
        max_tokens = 400,
        temperature = 0.2,
    })

    local util = require('model.util')

    require('model').setup({
        hl_group = 'Substitute',
        prompts = util.module.autoload('prompt_library'),
        default_prompt = {
            provider = openai,
            builder = function(input)
                return {
                    temperature = 0.3,
                    max_tokens = 120,
                    messages = {
                        {
                            role = 'system',
                            content = 'You are a helpful software engineering assistant.',
                        },
                        {
                            role = 'user',
                            content = input,
                        }
                    }
                }
            end
        }
    })
        
    vim.keymap.set("n", "<leader>fa", ':Telescope model mchat<CR>')
    vim.keymap.set("n", "<leader>fi", ':Mchat')
    end
}
