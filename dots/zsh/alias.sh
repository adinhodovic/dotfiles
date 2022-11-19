alias cat="bat"
alias cl='clear'
# lsd instead of ls
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# File dir
alias n="nnn"

alias df="duf"

alias c='z -I'
alias cc='z -c'
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

alias lg=lazygit

alias g-default="gcloud config configurations activate default && sed -i '/access-token:/d' ~/.kube/config"

create_envrc () {
  envrc_content=""
  if [ -e "./.env" ]; then
    envrc_content+='dotenv\n\n'
  fi
  envrc_content+='poetry env use 3.9\nlayout_poetry'
  echo $envrc_content > .envrc
}
alias cenvrc=create_envrc

# Usecase: seda accounts-service cron-service ArgoCD
search_and_replace_all () {
  rg "$3" --files-with-matches | xargs sed -i "s/$1/$2/g"
}
alias seda=search_and_replace_all
# Usecase: raf regexA regexB **
alias raf=rename_all_files

rename_all_files () {
  rename -v "$1" "$2" "$3"
}

alias tf='terraform'

alias top='bpytop'

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
alias tt=taskwarrior-tui

alias tempdir='tempdir=$(mktemp -d) && cd $tempdir'
alias cp='cp -v '
alias cp-img='xclip -selection clipboard -t image/png -i'
alias mv='mv -v '
alias h="history"
alias setxkbmapcaps="setxkbmap -option caps:swapescape68"
alias o='xdg-open'
alias v=nvim

alias dus=diskus
alias du=dust

alias copy="xclip -sel clip < $1"

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

