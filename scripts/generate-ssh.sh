#!/bin/bash
set -ex
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix hl-ops --filters 'Name=tag:Environment,Values=ops' --jumphost jumphost --user adin  > ~/.ssh/config-hl-euw-ops

AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix hl-dev-euw --filters 'Name=tag:Environment,Values=dev' --jumphost jumphost --user adin > ~/.ssh/config-hl-euw-dev
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix hl-test-euw --filters 'Name=tag:Environment,Values=test' --jumphost jumphost --user adin  > ~/.ssh/config-hl-euw-test
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix hl-prod-euw --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-hl-euw-prod


AWS_DEFAULT_REGION=ap-south-1 populate-ssh-configs aws --prefix hl-dev-ap-south --filters 'Name=tag:Environment,Values=dev' --jumphost jumphost --user adin > ~/.ssh/config-hl-ap-south-dev
AWS_DEFAULT_REGION=ap-south-1 populate-ssh-configs aws --prefix hl-test-ap-south --filters 'Name=tag:Environment,Values=test' --jumphost jumphost --user adin  > ~/.ssh/config-hl-ap-south-test
AWS_DEFAULT_REGION=ap-south-1 populate-ssh-configs aws --prefix hl-prod-ap-south --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-hl-ap-south-prod


AWS_DEFAULT_REGION=sa-east-1 populate-ssh-configs aws --prefix hl-dev-sa-east --filters 'Name=tag:Environment,Values=dev' --jumphost jumphost --user adin > ~/.ssh/config-hl-sa-east-dev
AWS_DEFAULT_REGION=sa-east-1 populate-ssh-configs aws --prefix hl-test-sa-east --filters 'Name=tag:Environment,Values=test' --jumphost jumphost --user adin  > ~/.ssh/config-hl-sa-east-test
AWS_DEFAULT_REGION=sa-east-1 populate-ssh-configs aws --prefix hl-prod-sa-east --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-hl-sa-east-prod

