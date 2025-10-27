# Django Docker Starter

A starter project for Django 5.x using Docker and PostgreSQL.

## Features

- Modern Django (5.x) — up-to-date framework with async improvements and the latest security fixes.
- PostgreSQL 16 — production-grade database running in Docker with an easy volume-backed setup.
- Automatic superuser creation — environment-driven superuser generator for quick development setup (see `src/create_superuser.py`).
- Docker-first workflow — ready-to-use `Dockerfile` and `docker-compose` configurations with clear dev/production separation.
- Reproducible environment — dependencies declared in `pyproject.toml` so builds are predictable across machines.
- Developer conveniences — simple commands for migrations, collectstatic, and management commands inside the container.
- Production-aware defaults — guidance for replacing secrets, configuring volumes, and securing settings before deployment.

### Minimum requirements

- Docker >= 24
- Docker Compose (v2+)

Setup Commands

Run the following commands sequentially to clone the repo, set up the environment file, and start the application.

# 1. Clone the repository and navigate into the folder

git clone [https://github.com/your-username/django-docker-starter.git](https://github.com/your-username/django-docker-starter.git)
cd django-docker-starter

# 2. Create the environment configuration file

touch .env

# 3. Build the Docker images and start the services in detached mode

docker compose up --build -d

Environment Variables

Copy the content below into your newly created .env file and replace the placeholder values (?) with your desired credentials.

# Database Credentials

POSTGRES_DB=django_db_name

# Django Docker Starter

A minimal, production-minded starter for Django 5.x apps using Docker and PostgreSQL.

Whether you're prototyping locally or bootstrapping a deployable service, this repo gives a small, well-documented foundation with sensible defaults.

--

## Highlights

- Ready for local development and CI: quick start with a single `docker compose up`.
- Built for reliability: uses PostgreSQL 16 and opinionated defaults for a smooth developer experience.
- Minimal friction: auto superuser creation and simple management command access via `docker compose exec web`.
- Clear separation: keep development tweaks and production settings isolated so you can deploy confidently.
- Small, maintainable footprint: lightweight image, declared dependencies, and minimal plumbing to customize.

## Table of contents

1. [Quick start](#quick-start)
2. [Environment variables (.env)](#environment-variables-env)
3. [Common commands](#common-commands)
4. [Project layout](#project-layout)
5. [Troubleshooting](#troubleshooting)
6. [Contributing & license](#contributing--license)

## Quick start

Prerequisites: Docker (>= 24) and Docker Compose V2+ installed.

1. Clone the repository and enter the folder

```bash
git clone https://github.com/your-username/django-docker-starter.git
cd django-docker-starter
```

2. Create a `.env` file at the project root and paste the example from below.

```bash
cp .env.example .env
# or create it manually: touch .env
```

3. Build images and start services (detached)

# Django Docker Starter

A tiny, production-aware starter for Django 5.x with PostgreSQL and Docker.

Features

- Modern Django (5.x) with Docker-first workflow
- PostgreSQL 16 (containerized, volume-backed)
- Auto-creates a superuser from env vars for quick dev boot
- Reproducible builds via `pyproject.toml`

Quick start (3 commands)

```bash
git clone https://github.com/your-username/django-docker-starter.git
cd django-docker-starter
cp .env.example .env  # or create .env and paste the sample below
docker compose up --build -d
```

Then run migrations:

```bash
docker compose exec web python manage.py migrate
```

.env (minimal example)

```env
# DB
POSTGRES_DB=django_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

# Superuser (auto-created on first run)
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_PASSWORD=changeme
DJANGO_SUPERUSER_EMAIL=admin@example.com

# Secret (replace in prod)
DJANGO_SECRET_KEY=replace_this_in_production
```

Common commands

- Stop: `docker compose down`
- Logs: `docker compose logs -f`
- Run manage command: `docker compose exec web python manage.py <cmd>`

Project layout (top-level)

- `src/` — Django project
- `Dockerfile`, `docker-compose.yml` — container setup
- `pyproject.toml` — dependencies

Notes & troubleshooting

- Requirements: Docker >=24, Docker Compose v2+
- If Postgres isn't ready, re-run `migrate` after a few seconds.
- Don't commit `.env`; use a secrets manager for production.
