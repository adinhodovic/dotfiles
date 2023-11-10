ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# clone a plugin, identify its init file, source it, and add it to your fpath
# https://github.com/mattmc3/zsh_unplugged
function plugin-load {
  local repo plugin_name plugin_dir initfile initfiles
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

function binary-download {
  local repo plugin_name plugin_dir
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
  done
}
#############################################
# Plugins
#############################################

# https://github.com/ohmyzsh/ohmyzsh/issues/5569
export DISABLE_MAGIC_FUNCTIONS=true
plugins=(
  golang
  kubectl
  ssh-agent
  command-not-found
)

repos=(
  Aloxaf/fzf-tab

  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  ohmyzsh/ohmyzsh
  zdharma-continuum/fast-syntax-highlighting

  djui/alias-tips
  wfxr/forgit
  hlissner/zsh-autopair
  adinhodovic/docker-alias
  adinhodovic/docker-compose-alias
  adinhodovic/ansible-alias
  adinhodovic/git-alias
  adinhodovic/terraform-alias
  adinhodovic/kubernetes-alias
)

binaries=(
  junegunn/fzf-git.sh
)

# now load your plugins
plugin-load $repos
binary-download $binaries

eval "$(zoxide init zsh)"
############################################
