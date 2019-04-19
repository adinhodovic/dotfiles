#!/bin/bash
set -ex
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix hl-ops --filters 'Name=tag:Environment,Values=ops' --jumphost jumphost --user adin  > ~/.ssh/config-hl-euw-ops
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix hl-prod-euw --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-hl-euw-prod
