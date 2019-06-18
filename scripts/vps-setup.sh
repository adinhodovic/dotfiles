#!/usr/bin/env bash
set -e

server=$1
# We need to cut down on SSH calls

# Install deps
ssh -t $1 sudo apt-get install unzip direnv
ssh $1 "wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip;unzip exa-linux-x86_64-0.8.0.zip;sudo mv exa-linux-x86_64 /usr/local/bin/exa;rm exa-linux-x86_64-0.8.0.zip"

# Install oh-my-zsh
ssh -t $1 "sudo sh -c $(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install terraform
ssh $1 "rm terraform*;wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip;unzip terraform_0.12.2_linux_amd64.zip"
ssh -t $1 "sudo mv terraform /usr/local/bin/"

# Make necessary dirs for syntax highlighting
ssh -t $1 "sudo mkdir -p /usr/share/zsh/plugins/zsh-syntax-highlighting/;rm -rf zsh-syntax-highlighting"
ssh -t $1 "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git"
ssh -t $1 "sudo rm -rf /usr/share/zsh/plugins/zsh-syntax-highlighting;sudo mv zsh-syntax-highlighting /usr/share/zsh/plugins/"

# Move oh my zsh to arch location!
ssh -t $1 "sudo rm -rf /usr/share/oh-my-zsh;sudo cp -r .oh-my-zsh /usr/share/oh-my-zsh"

# Copy zshrc
scp "/home/adin/.dotfiles/dots/zshrc" "$server:~/.zshrc"
