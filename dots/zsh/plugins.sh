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
      folder_initfiles=($plugin_dir/shell/*.plugin.{z,}sh(N) $plugin_dir/shell/*.{z,}sh{-theme,}(N))
      echo $folder_initfiles
      echo "$plugin_dir/shell/*.plugin."
      [[ ${#initfiles[@]} -gt 0 ]] || [[ ${#folder_initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }

      [[ ${#initfiles[@]} -gt 0 ]] && ln -sf "${initfiles[1]}" "$initfile"
      [[ ${#folder_initfiles[@]} -gt 0 ]] && ln -sf "${folder_initfiles[1]}" "$initfile"
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

export FZF_GIT_PREFIX='^g'

# Less oh my zsh updates
zstyle ':omz:update' frequency 30

# https://github.com/ohmyzsh/ohmyzsh/issues/5569
export DISABLE_MAGIC_FUNCTIONS=true
plugins=(
  aws
  aliases
  command-not-found
  # gcloud
  golang
  helm
  kubectl
  npm
  ssh-agent
  terraform
  poetry
  pyenv
  python
  uv
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
  adinhodovic/ansible-alias
  adinhodovic/git-alias
  adinhodovic/terraform-alias
  adinhodovic/kubernetes-alias
  adinhodovic/zsh-aws-vault
  trapd00r/LS_COLORS

  denisidoro/navi
)

binaries=(
  junegunn/fzf-git.sh
)

# now load your plugins
plugin-load $repos
binary-download $binaries

eval "$(zoxide init --cmd cd zsh))"
eval "$(zoxide init --cmd z zsh))"
eval "$(try init ~/playground/tries)"
############################################
