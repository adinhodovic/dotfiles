### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
#############################################
# Zinit Plugins
#############################################
zinit light Aloxaf/fzf-tab
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light djui/alias-tips                          # Give tips when not using aliases
zinit light wfxr/forgit                              # Git FZF utility tool
zinit light b4b4r07/emoji-cli                        # Emoji cli
zinit light hlissner/zsh-autopair                    # Autopair
zinit light bonnefoa/kubectl-fzf
zinit light olivierverdier/zsh-git-prompt            # git-prompt

zinit ice atload"eval $(lua ~/.zinit/plugins/skywind3000---z.lua/z.lua --init zsh fzf)"
zinit light skywind3000/z.lua

zinit snippet OMZP::golang
zinit snippet OMZP::kubectl
zinit snippet OMZP::sudo
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::command-not-found

zinit ice src"zshrc"
zinit light adinhodovic/docker-alias
zinit ice src"zshrc"
zinit light adinhodovic/docker-compose-alias
zinit ice src"zshrc"
zinit light adinhodovic/ansible-alias
zinit ice src"zshrc"
zinit light adinhodovic/git-alias
zinit ice src"zshrc"
zinit light adinhodovic/terraform-alias
zinit ice src"zshrc"
zinit light adinhodovic/kubernetes-alias
############################################
