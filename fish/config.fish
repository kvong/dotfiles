if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.config/fish/conf.d/tmux.fish
source ~/.config/fish/conf.d/exports.fish
source ~/.config/fish/conf.d/variables.fish
source ~/.config/fish/conf.d/startup.fish

# Starship Prompt
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
