#! /bin/bash
alias cl='clear'
# eza instead of ls
alias ls='eza'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# File dir
# alias f="yazi"
function f() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

alias df="duf"

# Zoxide inits with cd
alias c='cd -I'
alias cc='cd -c'
alias c.="cd .."
alias c..="cd ../.."
alias c...="cd ../../.."

# Globally ...
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# cd shortkeys
alias cd-="cd -"
alias cd.="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....='cd ../../../..'

alias ungron="gron --ungron"

lg() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

  lazygit "$@"

  if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
    cd "$(cat "$LAZYGIT_NEW_DIR_FILE")" || return

    # If running inside Neovim, keep the file for Neovim to read.
    if [ -z "$NVIM" ]; then
      rm -f "$LAZYGIT_NEW_DIR_FILE" >/dev/null 2>&1
    fi
  fi
}
alias lg=lg
# Remove this if we need the native ld command
alias ld=lazydocker

alias kl=~/go/bin/kl

# https://github.com/theopfr/somo
alias netstat=sumo

gcp_reset() {
  # Path to the JSON file
  json_file="$HOME/.kube/gke_gcloud_auth_plugin_cache"

  # Calculate the new expiry time (5 minutes in the past)
  new_expiry=$(date -u -d '5 minutes ago' +"%Y-%m-%dT%H:%M:%SZ")

  # Update the token_expiry field in the JSON file
  jq --arg new_expiry "$new_expiry" '.token_expiry = $new_expiry' "$json_file" >"${json_file}.tmp" && mv "${json_file}.tmp" "$json_file"
}
alias gcpreset=gcp_reset
gcp_list() {
  # Define the gcloud configuration command
  gcloud_cmd=("gcloud" "config" "configurations")

  # Function to list configurations and select one using fzf
  select_configuration() {
    "${gcloud_cmd[@]}" list | fzf --header-lines 1 --reverse | awk '{print $1}'
  }

  # Activate the specified configuration or prompt the user to select one
  configuration_to_activate="${1:-$(select_configuration)}"

  if [ -n "$configuration_to_activate" ]; then
    "${gcloud_cmd[@]}" activate "$configuration_to_activate"
    gcp_reset
  else
    echo "No configuration selected or specified."
    exit 1
  fi
}
alias gcplist=gcp_list

vd() {
  viddy -d -n 1 --shell zsh "$(which "$1" | cut -d' ' -f 4-)"
}

alias ping=gping
alias dig=dog
alias vd=vd

create_envrc() {
  envrc_content=""
  if [ -e "./.env" ]; then
    envrc_content+='dotenv\n\n'
  fi
  envrc_content+="poetry env use 3.11\nsource ./.venv/bin/activate"
  echo "$envrc_content" >.envrc
}
alias cenvrc=create_envrc

# Usecase: seda accounts-service cron-service ArgoCD
rsearch_and_replace_all() {
  rg "$3" --files-with-matches | xargs sed -i "s/$1/$2/g"
}
alias reda=rsearch_and_replace_all

# Usecase: seda accounts-service cron-service <file_name>
search_and_replace_all() {
  ls "$3" | xargs sed -i "s/$1/$2/g"
}
alias seda=search_and_replace_all
# Usecase: raf regexA regexB **
alias raf=rename_all_files

rename_all_files() {
  rename -v "$1" "$2" "$3"
}

alias tf='terraform'

alias top='btm --theme nord'

# Kubecolor
alias kubectl="kubecolor"

alias xc='xclip -sel clip'
function v() {
  if [[ -z "$1" ]]; then
    nvim $(__fsel)
  else
    nvim $@
  fi
}
alias ps='procs'
alias t=task
alias twall=t limit:none
alias tt=taskwarrior-tui

alias tempdir='tempdir=$(mktemp -d) && cd $tempdir'
alias cp='cp -v '
alias cp-img='xclip -selection clipboard -t image/png -i'
alias mv='mv -v '
alias h="history"
alias setxkbmapcaps="setxkbmap -option caps:swapescape68"
alias o='xdg-open'
alias v=nvim

alias du=dust

alias diff=difft
alias md-diff='/usr/bin/diff --unified'

alias copy="xclip -sel clip < $1"

# Ripgrep
alias rg="batgrep --paging=never"

# Bat
alias cat="bat"
# Diff files
alias bd="batdiff"

# avante
alias avante='nvim -c "lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)"'

# in your .bashrc/.zshrc/*rc
alias bathelp='bat --plain --language=help'
help() {
  "$@" --help 2>&1 | bathelp
}

# Use bat for help
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

function vf {
  if [ "$#" -lt 1 ]; then
    return 1
  fi
  results=$(ag --nogroup --column --color "$@" | fzf --multi --ansi --prompt 'AG>')
  if [ -n "$results" ]; then
    files=$(echo $results | awk -F ':' '{print $1":"$2":"$3}' | tr '\r\n' ' ')
    eval nvim "$files"
  fi
}

fcommit() {
  local commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
    local commit=$(echo "$commits" | fzf --tac +s -m -e --ansi --reverse) &&
    echo -n $(echo "$commit" | sed "s/ .*//")
}

run_taskwarrior_tui() {
  taskwarrior-tui
}
zle -N run_taskwarrior_tui

bindkey -M vicmd '^w' run_taskwarrior_tui
bindkey -M viins '^w' run_taskwarrior_tui
