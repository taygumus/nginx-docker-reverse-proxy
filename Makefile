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
		/scripts/certbot/certbot-first-issue/certbot-first-issue.sh

certbot-dry-run:
	@$(COMPOSE) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-dry-run/certbot-dry-run.sh

certbot-renew:
	@$(COMPOSE) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-renew/certbot-renew.sh

.PHONY: up down logs certbot-first-issue certbot-dry-run certbot-renew
