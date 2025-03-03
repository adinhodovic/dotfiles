source "/etc/profile.d/google-cloud-cli.sh"
eval "$(register-python-argcomplete pipx)"
source <(authzed completion zsh)
source <(zed completion zsh)

source /home/adin/.config/broot/launcher/bash/br

complete -o nospace -C "$(which tk)" tk

# We use kubecolor
compdef kubecolor=kubectl
