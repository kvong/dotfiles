if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.config/fish/conf.d/tmux.fish
source ~/.config/fish/conf.d/exports.fish
source ~/.config/fish/conf.d/variables.fish
source ~/.config/fish/conf.d/startup.fish
enable_transience

# Use !! and !$ from bash shell but make it better
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end
function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end
function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end
