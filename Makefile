# Makefile for OJS Development Environment

# Environment flags for Docker BuildKit
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Default target
.DEFAULT_GOAL := help

.PHONY: help build up down restart logs ps shell clean prune

# Show available commands
help:
	@echo "Available commands:"
	@echo "  make build     Build all services (parallel builds enabled)"
	@echo "  make up        Build and start all containers"
	@echo "  make down      Stop all containers and remove volumes"
	@echo "  make restart   Restart all containers cleanly"
	@echo "  make logs      Follow container logs"
	@echo "  make ps        List running containers"
	@echo "  make shell     Enter OJS container shell (bash)"
	@echo "  make clean     Stop and remove containers, images, volumes"
	@echo "  make prune     Deep clean unused Docker stuff"

# Build all services in parallel
build:
	docker compose build --parallel

# Bring up containers
up: build
	docker compose up

# Bring down containers and volumes
down:
	docker compose down -v

# Restart everything cleanly
restart:
	docker compose down -v
	docker compose build --parallel
	docker compose up

# Follow logs
logs:
	docker compose logs -f

# List containers
ps:
	docker compose ps

# Open a shell inside the OJS container
shell:
	docker exec -it ojs bash

# Clean everything (containers, volumes, images)
clean:
	docker compose down -v --rmi all

# Deep clean (optional: prune unused volumes, networks, etc.)
prune:
	docker system prune -af --volumes
