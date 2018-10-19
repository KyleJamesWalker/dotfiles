#!/bin/bash
# Installs the docker login helper: https://github.com/awslabs/amazon-ecr-credential-helper
#
# Troubleshooting:
#   Logs from the Amazon ECR Docker Credential Helper are stored in ~/.ecr/log

if [[ -z "$AWS_ECR" ]]; then
    echo "Must provide AWS_ECR in environment, add to ~/.zshrc-creds and source" 1>&2
    exit 1
fi

if [[ -z "$SSO_USER" ]]; then
    echo "Must provide SSO_USER in environment, add to ~/.zshrc-creds and source" 1>&2
    exit 1
fi

if [[ -z "$SSO_PASS" ]]; then
    echo "Must provide SSO_PASS in environment, add to ~/.zshrc-creds and source" 1>&2
    exit 1
fi


if ! type "docker-credential-ecr-login" > /dev/null; then
    echo "Installing docker-credential-ecr-login helper"
    brew install docker-credential-helper-ecr
else
    echo "docker-credential-ecr-login already installed helper"
fi


echo "Updating Docker Configuration"
tmp=$(mktemp)
jq '.auths = {"'$AWS_ECR'": {}}' ~/.docker/config.json > "$tmp" && mv "$tmp" ~/.docker/config.json
jq '.credHelpers = {"'$AWS_ECR'": "adfs-ecr-login"}' ~/.docker/config.json > "$tmp" && mv "$tmp" ~/.docker/config.json
jq '.credsStore = "adfs-ecr-login"' ~/.docker/config.json > "$tmp" && mv "$tmp" ~/.docker/config.json
echo "Resulting Configuration"
cat ~/.docker/config.json | jq

PYENV_VERSION=genv pip install -U awscli aws-adfs

cp docker-credential-adfs-ecr-login /usr/local/bin/docker-credential-adfs-ecr-login
