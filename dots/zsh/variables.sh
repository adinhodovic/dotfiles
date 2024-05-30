###############################
# Set variables
###############################
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.poetry/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.krew/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

export EDITOR="nvim"

export GOPATH="$HOME/go"

export TERMINAL=/usr/bin/alacritty

export RIPGREP_CONFIG_PATH=~/.ripgreprc

export FONTCONFIG_PATH=~/.config/fontconfig/fonts.conf

export XDG_DOWNLOAD_DIR="$HOME/downloads"
export GTK_USE_PORTAL=1

export PYTHON_VENV_NAME=.venv

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
