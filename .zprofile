export EDITOR=nvim

alias ll="nnn -deHo"
alias vim=nvim
alias resource="source $HOME/.zshrc"

alias config="/usr/bin/git --git-dir=$HOME/.config_bare/ --work-tree=$HOME"

alias docker=podman
alias k=kubectl

# Required by NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
