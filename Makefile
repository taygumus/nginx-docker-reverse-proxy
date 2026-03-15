COMPOSE := docker compose

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

logs:
	@$(COMPOSE) logs -f

certbot-first-issue:
	@$(COMPOSE) run --rm \
	  --entrypoint sh \
	  certbot \
	  /certbot/certbot-first-issue/certbot-first-issue.sh "$(CERT_SAN)"

certbot-dry-run:
	@$(COMPOSE) run --rm \
		--entrypoint sh \
		certbot \
		/certbot/certbot-dry-run/certbot-dry-run.sh

.PHONY: up down logs certbot-first-issue certbot-dry-run
