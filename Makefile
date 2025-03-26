,PHONY: git/config efs/mkdir efs/mount prometheus/update compose/up compose/down compose/logs compose/logs/charon compose/logs/prometheus compose/logs/promtail compose/logs/validator-ejector compose/logs/lido-dv-exit compose/ps compose/build
SHELL := /usr/bin/bash

# Set Git user email and name
git/config:
	git config --global user.email "work@mageyuki.com"
	git config --global user.name "mageyuki"
	git config --global core.editor vim

# mkdir for EFS
efs/mkdir:
	mkdir -p /home/ssm-user/lido-charon-distributed-validator-node/.charon
	mkdir -p /home/ssm-user/lido-charon-distributed-validator-node/.validator-ejector

# mount EFS
efs/mount:
	sudo mount -t efs $(aws efs describe-file-systems --query "FileSystems[?Tags[?Key=='Name' && Value=='efs-obol-charon']].FileSystemId" --output text) /home/ssm-user/lido-charon-distributed-validator-node/.charon
	sudo mount -t efs $(aws efs describe-file-systems --query "FileSystems[?Tags[?Key=='Name' && Value=='efs-obol-exitmessages']].FileSystemId" --output text) /home/ssm-user/lido-charon-distributed-validator-node/.validator-ejector

# update prometheus.yml
prometheus/update:
	export PROM_REMOTE_WRITE_TOKEN=$(aws secretsmanager get-secret-value --secret-id manual-input-for-obol --query SecretString --output text | jq -r '.PROM_REMOTE_WRITE_TOKEN')
	envsubst < prometheus/prometheus.yml.tmpl > prometheus/prometheus.yml

# docker-compose up background
compose/up:
	sudo docker compose -f docker-compose.yml up -d

# docker-compose down
compose/down:
	sudo docker compose -f docker-compose.yml down

# docker-compose logs
compose/logs:
	sudo docker compose logs -f

# docker-compose logs charon
compose/logs/charon:
	sudo docker compose logs charon -f

# docker-compose logs prometheus
compose/logs/prometheus:
	sudo docker compose logs prometheus -f

# docker-compose logs prometheus
compose/logs/promtail:
	sudo docker compose logs -f logging.yml promtail -f

# docker-compose logs validator-ejector
compose/logs/validator-ejector:
	sudo docker compose logs validator-ejector -f

# docker-compose logs lido-dv-exit
compose/logs/lido-dv-exit:
	sudo docker compose logs lido-dv-exit -f

# docker-compose ps
compose/ps:
	sudo docker compose ps

# docker-compose build
compose/build:
	sudo docker compose build --no-cache
