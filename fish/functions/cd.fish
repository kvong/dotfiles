function cd --description 'Change directory and save new directory so new shell will start in the latest directory'
    builtin cd $argv && ls;
    pwd > ~/.latest-dir
    set -Ux CURDIR "$(pwd)"
    zoxide add $CURDIR # Save the last directory to zoxide database
end
