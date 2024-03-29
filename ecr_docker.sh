#!/bin/bash
# Installs the docker login helper: https://github.com/awslabs/amazon-ecr-credential-helper
#
# Troubleshooting:
#   Logs from the Amazon ECR Docker Credential Helper are stored in ~/.ecr/log

if [[ -z "$AWS_ECR" ]]; then
    echo "Must provide AWS_ECR in environment, add to ~/.zshrc-creds and source" 1>&2
    exit 1
fi

echo "Enter your sso password for the OSX Keychain"
security add-generic-password -a ${USER} -s sso -w

if ! type "docker-credential-ecr-login" > /dev/null; then
    echo "Installing docker-credential-ecr-login helper"
    brew install docker-credential-helper-ecr
else
    echo "docker-credential-ecr-login already installed helper"
fi

echo "Updating Docker Configuration"
tmp=$(mktemp)
jq '.auths = {"'$AWS_ECR'": {}, "https://index.docker.io/v1/": {}}' ~/.docker/config.json > "$tmp" && mv "$tmp" ~/.docker/config.json
jq '.credHelpers = {"'$AWS_ECR'": "sso-ecr-login", "https://index.docker.io/v1/": "osxkeychain"}' ~/.docker/config.json > "$tmp" && mv "$tmp" ~/.docker/config.json
jq '.credsStore = "sso-ecr-login"' ~/.docker/config.json > "$tmp" && mv "$tmp" ~/.docker/config.json
echo "Resulting Configuration"
cat ~/.docker/config.json | jq

cp docker-credential-sso-ecr-login /usr/local/bin/docker-credential-sso-ecr-login
