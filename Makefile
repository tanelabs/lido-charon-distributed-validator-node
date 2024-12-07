SHELL := /usr/bin/bash

# docker-compose up background
compose/up:
	NEW_RELIC_INFRASTRUCTURE_LICENSE_KEY=$(shell aws secretsmanager get-secret-value --secret-id newrelic-license-key | jq -r ".SecretString" | jq -r .NEW_RELIC_LICENSE_KEY) sudo docker compose up -d

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
