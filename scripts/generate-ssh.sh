#!/bin/bash
set -ex
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix amb-ops --filters 'Name=tag:Environment,Values=ops' --jumphost jumphost --user adin  > ~/.ssh/config-amb-euw-ops

AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix amb-dev-euw --filters 'Name=tag:Environment,Values=dev' --jumphost jumphost --user adin > ~/.ssh/config-amb-euw-dev
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix amb-test-euw --filters 'Name=tag:Environment,Values=test' --jumphost jumphost --user adin  > ~/.ssh/config-amb-euw-test
AWS_DEFAULT_REGION=eu-west-1 populate-ssh-configs aws --prefix amb-prod-euw --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-amb-euw-prod


AWS_DEFAULT_REGION=ap-south-1 populate-ssh-configs aws --prefix amb-dev-ap-south --filters 'Name=tag:Environment,Values=dev' --jumphost jumphost --user adin > ~/.ssh/config-amb-ap-south-dev
AWS_DEFAULT_REGION=ap-south-1 populate-ssh-configs aws --prefix amb-test-ap-south --filters 'Name=tag:Environment,Values=test' --jumphost jumphost --user adin  > ~/.ssh/config-amb-ap-south-test
AWS_DEFAULT_REGION=ap-south-1 populate-ssh-configs aws --prefix amb-prod-ap-south --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-amb-ap-south-prod


AWS_DEFAULT_REGION=sa-east-1 populate-ssh-configs aws --prefix amb-dev-sa-east --filters 'Name=tag:Environment,Values=dev' --jumphost jumphost --user adin > ~/.ssh/config-amb-sa-east-dev
AWS_DEFAULT_REGION=sa-east-1 populate-ssh-configs aws --prefix amb-test-sa-east --filters 'Name=tag:Environment,Values=test' --jumphost jumphost --user adin  > ~/.ssh/config-amb-sa-east-test
AWS_DEFAULT_REGION=sa-east-1 populate-ssh-configs aws --prefix amb-prod-sa-east --filters 'Name=tag:Environment,Values=prod' --jumphost jumphost --user adin  > ~/.ssh/config-amb-sa-east-prod

