COMPOSE := docker compose

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

logs:
	@$(COMPOSE) logs -f

certbot-first-issue:
	@if [ -z "$(DOMAINS)" ]; then \
		echo "Usage: make certbot-first-issue DOMAINS=\"example.com www.example.com\""; \
		exit 1; \
	fi
	@$(COMPOSE) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-first-issue.sh $(DOMAINS)

certbot-dry-run:
	@$(COMPOSE) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-dry-run.sh

certbot-renew:
	@$(COMPOSE) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-renew.sh

.PHONY: up down logs certbot-first-issue certbot-dry-run certbot-renew
