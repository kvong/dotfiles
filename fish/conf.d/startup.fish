# Start keychain
source $HOME/.keychain/$hostname-fish

eval "$(zoxide init fish)"

if test -f ~/.latest-dir 
    cd $(cat ~/.latest-dir)
end

starship init fish | source

