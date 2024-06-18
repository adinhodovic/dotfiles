source "/etc/profile.d/google-cloud-cli.sh"
eval "$(register-python-argcomplete pipx)"
source <(authzed completion zsh)

# We use kubecolor
compdef kubecolor=kubectl
