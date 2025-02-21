if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.config/fish/conf.d/tmux.fish
source ~/.config/fish/conf.d/exports.fish
source ~/.config/fish/conf.d/variables.fish
source ~/.config/fish/conf.d/startup.fish

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

function find_file
    set -l initial_path (pwd)
    if test (count $argv) -gt 0
        set initial_path $argv[1]
    end
    find $initial_path -type f | fzf --preview 'bat --color=always --line-range :500 {}'
end

function find_grep
    # Set search directory to current directory or to provided argument
    set search_dir (pwd)
    if set -q argv[1]
        set search_dir $argv[1]
    end

    # Use rg (ripgrep) or grep for performance and include line numbers. Pipe into fzf with file content previews.
    rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/' '' $search_dir | fzf --ansi --delimiter : --preview "bat --style=numbers --color=always --line-range {2}: {1}" --preview-window=up:60%
end
