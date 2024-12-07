SHELL := /usr/bin/bash
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
