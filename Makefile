SHELL := /usr/bin/bash

# Set Git user email and name
git/config:
	git config --global user.email "work@mageyuki.com"
	git config --global user.name "mageyuki"

# mkdir for EFS
efs/mkdir:
	mkdir -p /home/ssm-user/lido-charon-distributed-validator-node/.charon
	mkdir -p /home/ssm-user/lido-charon-distributed-validator-node/.validator-ejector

# mount EFS
efs/mount:
	sudo mount -t efs $(aws efs describe-file-systems --query "FileSystems[?Tags[?Key=='Name' && Value=='efs-obol-charon']].FileSystemId" --output text) /home/ssm-user/lido-charon-distributed-validator-node/.charon
	sudo mount -t efs $(aws efs describe-file-systems --query "FileSystems[?Tags[?Key=='Name' && Value=='efs-obol-exitmessages']].FileSystemId" --output text) /home/ssm-user/lido-charon-distributed-validator-node/.validator-ejector

# generate New Relic license key file
get/license-key:
	@echo "license_key: $(shell aws secretsmanager get-secret-value --secret-id newrelic-license-key | jq -r ".SecretString" | jq -r .NEW_RELIC_LICENSE_KEY)" > newrelic-infra.yml

# docker-compose up background
compose/up:
	sudo docker compose up -d

# docker-compose down
compose/down:
	sudo docker compose down

# docker-compose logs
compose/logs:
	sudo docker compose logs -f

# docker-compose ps
compose/ps:
	sudo docker compose ps

# docker-compose build
compose/build:
	sudo docker compose build --no-cache
