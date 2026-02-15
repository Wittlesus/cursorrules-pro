# Makefile for Python API
# Run: make <command>

.PHONY: help install dev test lint format type-check migrate-create migrate-up migrate-down clean

help:  ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

install:  ## Install dependencies
	poetry install

dev:  ## Start development server
	python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

test:  ## Run tests
	python -m pytest -v

test-cov:  ## Run tests with coverage
	python -m pytest --cov=app --cov-report=html --cov-report=term tests/

lint:  ## Run linter (ruff)
	ruff check .

format:  ## Format code (black)
	black .
	ruff check --fix .

type-check:  ## Run type checker (mypy)
	mypy app/

migrate-create:  ## Create new migration (usage: make migrate-create MSG="add users table")
	alembic revision --autogenerate -m "$(MSG)"

migrate-up:  ## Apply all migrations
	alembic upgrade head

migrate-down:  ## Rollback last migration
	alembic downgrade -1

db-reset:  ## Drop and recreate database (WARNING: destructive)
	@echo "This will drop and recreate the database. Press Ctrl+C to cancel."
	@sleep 3
	alembic downgrade base
	alembic upgrade head

clean:  ## Remove cache and generated files
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name "htmlcov" -exec rm -rf {} +

docker-build:  ## Build Docker image
	docker build -t api:latest .

docker-run:  ## Run Docker container
	docker run -p 8000:8000 --env-file .env api:latest

all: format lint type-check test  ## Run all checks (format, lint, type-check, test)
