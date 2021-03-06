alias cat="bat"
# lsd instead of ls
alias ls='lsd'
alias cl='clear'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

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

create_envrc () {
  envrc_content=""
  if [ -e "./.env" ]; then
    envrc_content+='dotenv\n\n'
  fi
  envrc_content+='poetry env use 3.9\nlayout_poetry'
  echo $envrc_content > .envrc
}

alias cenvrc=create_envrc

alias '?'='googler'
alias define='googler -n 2 define'

alias seda=search_and_replace_all
# Usecase raf regexA regexB **
alias raf=rename_all_files

search_and_replace_all () {
  rg "$3" --files-with-matches | xargs sed -i "s/$1/$2/g"
}

rename_all_files () {
  rename -v "$1" "$2" "$3"
}

alias tf='terraform'
alias top='vtop --theme gruvbox'

alias xc='xclip -sel clip'
function v() {
  if [[ -z "$1" ]]; then
    nvim $(__fsel)
  else
    nvim $@
  fi
}
alias v=v
alias ps='procs'
alias s-hl='vps-sync hl-ops-jumphost ~/company/honeylogic/ops ~/ops ops'
alias t=taskwarrior
alias tempdir='tempdir=$(mktemp -d) && cd $tempdir'

# cd shortkeys
alias cd.="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....='cd ../../../..'

# Z.lua
alias zz='z -c'      # restrict matches to subdirs of $PWD
alias zi='z -i'      # cd with interactive selection
alias zf='z -I'      # use fzf to select in multiple matches
alias zb='z -b'      # quickly cd to the parent directory
alias zh='z -I -t .'

alias tempdir='tempdir=$(mktemp -d) && cd $tempdir'
alias cp='cp -v '
alias mv='mv -v '
alias h="history"
alias cd-="cd -"
alias setxkbmapcaps="setxkbmap -option caps:swapescape68"
alias o='xdg-open'
alias v=nvim
alias dus=diskus

alias aws_kubeconfig="aws eks update-kubeconfig --name $1 --alias $2"

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

