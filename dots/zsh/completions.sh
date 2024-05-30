source "/etc/profile.d/google-cloud-cli.sh"
eval "$(register-python-argcomplete pipx)"

# We use kubecolor
compdef kubecolor=kubectl
