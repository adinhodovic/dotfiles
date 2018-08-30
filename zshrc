#######################################################
####### Arch Anywhere ZSH configuration file    #######
#######################################################

### Set/unset ZSH options
#########################
# setopt NOHUP
# setopt NOTIFY
# setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME
unsetopt BG_NICE
setopt CORRECT
setopt EXTENDED_HISTORY
# setopt HASH_CMDS
setopt MENUCOMPLETE
setopt ALL_EXPORT

### Set/unset  shell options
############################
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

### Autoload zsh modules when they are referenced
#################################################
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="aphrodite"

plugins=(
  ssh-agent
)
source $ZSH/oh-my-zsh.sh
# Set vi-mode
bindkey -v
#zmodload -ap zsh/mapfile mapfile
# Move to the end of the line and exclude whitespace
tmux-copy-mode() {
if [ -n "$TMUX" ]; then
  tmux copy-mode
fi
}
# Paste from clipboard
vi-append-x-selection-before () {
RBUFFER="$(xclip -o)$RBUFFER"
}
vi-append-x-selection-after () {
CURSOR=$((CURSOR+1))
RBUFFER="$(xclip -o)$RBUFFER"
}
function noop () {}
zle -N noop

bindkey '^[[A' noop
bindkey '^[[B' noop
bindkey '^[[C' noop
bindkey '^[[D' noop

end-of-line-no-whitespace() {
zle vi-end-of-line
zle vi-backward-word-end
}
zle -N end-of-line-no-whitespace

zle -N vi-append-x-selection-before
zle -N vi-append-x-selection-after

zle -N tmux-copy-mode

# Enable reverse-menu-complete
zmodload zsh/complist
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Highlight selected option in tab completion menu
zstyle ':completion:*' menu select

# Key bindings. Wanna find weird keycodes? use cat
# Fix backspace delete in vi-mode
# http://www.zsh.org/mla/users/2009/msg00812.html
bindkey "^?" backward-delete-char
# Movement bindings
bindkey -M vicmd q vi-backward-word
bindkey -M vicmd 0 noop
bindkey -M vicmd Q vi-beginning-of-line
bindkey -M vicmd $ noop
bindkey -M vicmd W end-of-line-no-whitespace

bindkey -M vicmd P vi-append-x-selection-before
bindkey -M vicmd p vi-append-x-selection-after

bindkey -M vicmd v tmux-copy-mode

function tmux-search {
  tmux copy-mode && tmux send-keys '?' && tmux send-keys \
    BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace
}
zle -N tmux-search

bindkey -M vicmd '/' tmux-search

# Reverse scrolling shift+tab
bindkey -M menuselect '^[[Z' reverse-menu-complete
# Aliases
# ------------
# Allows 256 colors as background in terminal, used for Vi
alias tmux="tmux -2"
# Todo: Write a function instead
alias cd.="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....='cd ../../../..'
alias tempdir='tempdir=$(mktemp -d) && cd $tempdir'
alias cp='cp -v '
alias mv='mv -v '
alias h="history"
alias cd-="cd -"
alias ls='ls --color=auto --classify -lrt --block-size=MB'
alias setxkbmapcaps="setxkbmap -option caps:swapescape68"
alias o='xdg-open'
alias v=nvim
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
### Set variables
#################
export PATH="/usr/local/bin:/usr/local/sbin/:$PATH:/home/adin/go/bin/"

HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"

### Set prompt
##############
unsetopt ALL_EXPORT

### Set alias
#############
alias ll='ls -al'
alias xc='xclip -sel clip'
alias v='nvim'
### Bind keys
#############
autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
  '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
  named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
  avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
  firebird gnats haldaemon hplip irc klog list man cupsys postfix\
  proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
  files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
  files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
  users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
  hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

### Source plugins
##################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export TERMINAL=/usr/bin/alacritty

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
