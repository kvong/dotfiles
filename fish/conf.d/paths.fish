set -e fish_user_paths

set -q PATH; or set PATH ''
set -gx PATH $HOME/scripts/ $HOME/.local/bin/ $PATH

set -gx VISUAL vim
set -gx EDITOR $VISUAL
set -gx NVM_DIR $HOME/.nvm
set -gx _ZO_ECHO '1'

set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

set -gx PATH $PATH $HOME/.cargo/bin
