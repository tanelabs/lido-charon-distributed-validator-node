SHELL := /usr/bin/bash

# docker-compose up background
compose/up:
	docker-compose up -d -e NEW_RELIC_INFRASTRUCTURE_LICENSE_KEY=(shell aws secretsmanager get-secret-value --secret-id newrelic-license-key | jq -r ".SecretString" | jq -r .NEW_RELIC_LICENSE_KEY)

# docker-compose down
compose/down:
	docker-compose down

# docker-compose logs
compose/logs:
	docker-compose logs -f

# docker-compose ps
compose/ps:
	docker-compose ps

# docker-compose build
compose/build:
	docker-compose build --no-cache
