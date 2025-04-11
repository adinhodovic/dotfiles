###############################
# Key bindings
###############################

# Set vi-mode
bindkey -v

# Move to the end of the line and exclude whitespace
tmux-copy-mode() {
  if [ -n "$TMUX" ]; then
    tmux copy-mode
  fi
}

# Paste from clipboard
vi-append-x-selection-before() {
  RBUFFER="$(xclip -o)$RBUFFER"
}
vi-append-x-selection-after() {
  CURSOR=$((CURSOR + 1))
  RBUFFER="$(xclip -o)$RBUFFER"
}

end-of-line-no-whitespace() {
  zle vi-end-of-line
  zle vi-backward-word-end
}

zle -N end-of-line-no-whitespace

zle -N vi-append-x-selection-before
zle -N vi-append-x-selection-after

# Key bindings. Wanna find weird keycodes? use cat
# Fix backspace delete in vi-mode
# http://www.zsh.org/mla/users/2009/msg00812.html
bindkey "^?" backward-delete-char

# Movement bindings
bindkey -M vicmd q vi-backward-word
bindkey -M vicmd Q vi-beginning-of-line
bindkey -M vicmd W end-of-line-no-whitespace

bindkey -M vicmd P vi-append-x-selection-before
bindkey -M vicmd p vi-append-x-selection-after

function tmux-search {
  tmux copy-mode && tmux send-keys '?' && tmux send-keys \
    BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace BSpace
}
zle -N tmux-search
bindkey -M vicmd '/' tmux-search

zle -N tmux-copy-mode
bindkey -M vicmd v tmux-copy-mode

# Reverse scrolling shift+tab
bindkey -M menuselect '^[[Z' reverse-menu-complete

function sol-func() {
  local current_line="${BUFFER}"
  BUFFER=$(echo "$current_line" | sol -p -c -b -r -a -s -jqobj -jqarr -jqop comma)
  CURSOR=${#BUFFER}
}
zle -N sol-func
bindkey -M vicmd '@' sol-func

# Add direnv
eval "$(direnv hook zsh)"

#############################################
# Automation
#############################################
function git-standup-last-month() {
  python <<EOF
from datetime import date, timedelta
import subprocess
import os
today = date.today()
beginning_of_this_week = today - timedelta(days=today.weekday())
end_of_this_week = beginning_of_this_week + timedelta(days=30)
cmd = f"git standup -A {beginning_of_this_week} -B {end_of_this_week} -s"
home = os.path.expanduser("~")
dirs = [
  os.path.join(home, "work/**/**"),
  os.path.join(home, "dotfiles"),
  os.path.join(home, "company"),
  os.path.join(home, "personal"),
]
for dir in dirs:
  subprocess.run(cmd, shell=True, cwd=dir)
EOF
}

function git-standup-last-week() {
  python <<EOF
from datetime import date, timedelta
import subprocess
import os
today = date.today()
beginning_of_last_week = today - timedelta(days=today.weekday() + 7)
end_of_last_week = beginning_of_last_week + timedelta(days=7)
cmd = f"git standup -A {beginning_of_last_week} -B {end_of_last_week} -s"
home = os.path.expanduser("~")
dirs = [
  os.path.join(home, "work/**/**"),
  os.path.join(home, "dotfiles"),
  os.path.join(home, "company"),
  os.path.join(home, "personal"),
]
for dir in dirs:
  subprocess.run(cmd, shell=True, cwd=dir)
EOF
}

function git-standup-this-week() {
  python <<EOF
from datetime import date, timedelta
import subprocess
import os
today = date.today()
beginning_of_this_week = today - timedelta(days=today.weekday())
end_of_this_week = beginning_of_this_week + timedelta(days=7)
cmd = f"git standup -A {beginning_of_this_week} -B {end_of_this_week} -s"
home = os.path.expanduser("~")
dirs = [
  os.path.join(home, "work/**/**"),
  os.path.join(home, "dotfiles"),
  os.path.join(home, "company"),
  os.path.join(home, "personal"),
]
for dir in dirs:
  subprocess.run(cmd, shell=True, cwd=dir)
EOF
}

bindkey '^n' _navi_widget
