# Start keychain
source $HOME/.keychain/$hostname-fish

eval "$(zoxide init fish)"

if test -f ~/.latest-dir 
    cd $(cat ~/.latest-dir)
end

# Update Env if keyball is true; use this to switch up the qtile config
if lsusb | grep -q "ID 5957:0200 Yowkees Keyball39"
    set -gx KEYBALL39_IS_ACTIVE true
end

starship init fish | source

python3 ~/.config/alacritty/update_alacritty_from_env.py

