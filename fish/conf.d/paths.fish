set -e fish_user_paths

set -q PATH; or set PATH ''
set -gx PATH $HOME/scripts/ $HOME/.local/bin/ $PATH

set -gx VISUAL vim
set -gx EDITOR $VISUAL
set -gx _ZO_ECHO '1'

set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -gx PATH $PATH $GOROOT/bin

set -gx PATH $PATH $HOME/.cargo/bin

set -gx TZ 'America/Chicago'
set -gx PATH $PATH:/usr/local/go/bin
set -gx PATH $HOME"/.config/herd-lite/bin:$PATH"
set -gx PHP_INI_SCAN_DIR $HOME"/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
set -gx NVM_DIR "$HOME/.nvm"
if test -s "$NVM_DIR/nvm.sh"
    source_bash "$NVM_DIR/nvm.sh"
end
