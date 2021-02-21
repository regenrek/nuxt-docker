#-----------------------------------------------------------
# Docker
#-----------------------------------------------------------

# Wake up docker containers
up:
	docker-compose up -d

# Shut down docker containers
down:
	docker-compose down

# Show a status of each container
status:
	docker-compose ps

# Status alias
s: status

# Show logs of each container
logs:
	docker-compose logs

# Restart all containers
restart: down up

# Restart the client container
restart-client:
	docker-compose restart client

# Restart the client container alias
rc: restart-client

# Show the client logs
logs-client:
	docker-compose logs client

# Show the client logs alias
lc: logs-client

# Build and up docker containers
build:
	docker-compose up -d --build

# Build containers with no cache option
build-no-cache:
	docker-compose build --no-cache

# Build and up docker containers
rebuild: down build

# Run terminal of the client container
client:
	docker-compose exec client /bin/sh


#-----------------------------------------------------------
# Logs
#-----------------------------------------------------------

# Clear file-based logs
logs-clear:
	sudo rm docker/dev/nginx/logs/*.log
	sudo rm docker/dev/supervisor/logs/*.log

#-----------------------------------------------------------
# Dependencies
#-----------------------------------------------------------

# Update yarn dependencies
yarn-update:
	docker-compose exec client yarn update

# Update all dependencies
dependencies-update: yarn-update

# Show yarn outdated dependencies
yarn-outdated:
	docker-compose exec yarn outdated

# Show all outdated dependencies
outdated: yarn-update yarn-outdated

#-----------------------------------------------------------
# Installation
#-----------------------------------------------------------

# Copy the NuxtJS environment file
env-client:
	cp .env.client client/.env

# Install the environment
install: build env-client rc

#-----------------------------------------------------------
# Git commands
#-----------------------------------------------------------

# Undo the last commit
git-undo:
	git reset --soft HEAD~1

# Make a Work In Progress commit
git-wip:
	git add .
	git commit -m "WIP"

# Export the codebase as app.zip archive
git-export:
	git archive --format zip --output app.zip master


#-----------------------------------------------------------
# Frameworks installation
#-----------------------------------------------------------

# Nuxt.JS
reinstall-nuxt:
	docker-compose down
	sudo rm -rf client
	mkdir client
	docker-compose up -d
	docker-compose run client yarn create nuxt-app .
	sudo chown ${USER}:${USER} -R client
	cp .env.client client/.env
	sed -i "1i require('dotenv').config()" client/nuxt.config.js
	docker-compose restart client
	docker-compose exec client yarn info nuxt version

#-----------------------------------------------------------
# Clearing
#-----------------------------------------------------------

# Shut down and remove all volumes
remove-volumes:
	docker-compose down --volumes

# Remove all existing networks (useful if network already exists with the same attributes)
prune-networks:
	docker network prune