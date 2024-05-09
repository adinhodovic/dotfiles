fzf_opts=(
  --reverse
  --bind ctrl-space:toggle-preview
  --bind ctrl-j:down
  --bind ctrl-k:up
  --bind tab:down
  --bind 'shift-tab':up
  --bind ctrl-d:half-page-down
  --bind ctrl-u:half-page-up
  --bind ctrl-s:toggle-sort
  --bind ctrl-e:preview-down
  --bind ctrl-y:preview-up
)

# Useful for FZF-GIT, multiple keybindings e.g. CTRL-G + CTRL-F
export KEYTIMEOUT=1000

export FZF_DEFAULT_OPTS="${fzf_opts[*]}"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_R_OPTS='--exact'

if which fd &> /dev/null; then
  # To apply the command to CTRL-T as well
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_ALT_C_OPTS="--preview 'eza --tree {}'"

function fzf-docker-logs {
  matches=$(docker ps --format 'table {{ .Names }}\t{{ .Image }}')
  selection=$(echo $matches | fzf --header-lines=1 | awk '{print $1}')
  if [ ! -z $selection ]; then
    args="${@:-"--tail 100 -f"}"
    BUFFER="docker logs -f --tail 100 $args $selection"
    zle accept-line
  fi
}
zle -N fzf-docker-logs

function fzf-docker-exec {
  matches=$(docker ps --format 'table {{ .Names }}\t{{ .Image }}')
  selection=$(echo $matches | fzf --header-lines=1 | awk '{print $1}')
  if [ ! -z $selection ]; then
    cmd="${@:-"sh -c 'bash || sh'"}"
    BUFFER="docker exec -it $selection $cmd"
    zle accept-line
  fi
}
zle -N fzf-docker-exec

fcommit() {
  local commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  local commit=$(echo "$commits" | fzf --tac +s -m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

bindkey -M vicmd '\-'   fzf-file-widget

bindkey -M vicmd '^l'   fzf-docker-logs
bindkey -M viins '^l'   fzf-docker-logs

bindkey -M vicmd '^x'   fzf-docker-exec
bindkey -M viins '^x'   fzf-docker-exec

###########################################
# Fzf-tab
###########################################
enable-fzf-tab

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 50 0
zstyle ':fzf-tab:complete:_zlua:*' query-string input
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

###########################################
# Fzf-git
###########################################

ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
source $ZPLUGINDIR/fzf-git.sh/fzf-git.sh
