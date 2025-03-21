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

# docker-compose up background
compose/up:
	sudo docker compose -f docker-compose.yml -f logging.yml up -d

# docker-compose down
compose/down:
	sudo docker compose -f docker-compose.yml -f logging.yml down

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
