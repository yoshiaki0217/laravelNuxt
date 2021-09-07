.DEFAULT_GOAL := help

build-local: ## [dev] 開発環境を構築する
	composer install
	php artisan key:generate
	php artisan migrate:fresh
	php artisan db:seed

serve:
	docker-compose up php mysql nginx

login-php: ## [dev] php container をlocalhost:8000で起動する
	docker exec -it php /bin/bash

login-nginx:
	docker exec -it nginx ash

composer-install: ## [dev] Run composer install
	docker-compose run --rm php composer install

tinker: ## [dev] Run Tinker
	docker-compose run --rm php php artisan tinker

ide-helper: ## [dev] ide-helperを実行する
	docker-compose run --rm php php artisan ide-helper:eloquent
	docker-compose run --rm php php artisan ide-helper:generate
	docker-compose run --rm php php artisan ide-helper:meta

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
