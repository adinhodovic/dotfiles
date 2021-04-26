###############################
# Set variables
###############################
export PATH="$PATH:/usr/local/bin:/usr/local/sbin/:/home/adin/go/bin/"
export PATH="$PATH:$HOME/.poetry/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.krew/bin"
export PATH="$PATH:/home/adin/.local/bin/"
export PATH="$PATH:/home/adin/.gem/ruby/2.7.0/bin"
export PATH="$PATH:/home/adin/.linkerd2/bin"
export PATH="$PATH:/.local/share/nvim/plugged/vim-terraform-completion/bin/tffilter"
export PATH="$PATH:/home/adin/work/tidepool/development/bin"
export PATH="$PATH:/home/adin/work/tidepool/tpctl/cmd"

export PYTHONPATH="/usr/local/lib/python3.9/site-packages:$PYTHONPATH"

export TERMINAL=/usr/bin/alacritty
export TERM=screen-256color

export RIPGREP_CONFIG_PATH=~/.ripgreprc

NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export NODE_PATH="${NPM_PACKAGES}/lib/node_modules"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
