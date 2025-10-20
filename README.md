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

```bash
docker compose up --build -d
```

4. Run migrations and (optionally) load initial data

```bash
docker compose exec web python manage.py migrate
```

After those steps the site is available at: http://localhost:8000
The admin is at: http://localhost:8000/admin

Notes:

- The repository includes a small helper that automatically creates a Django superuser from environment variables on first-run. See the `create_superuser.py` script under `src/`.

## Environment variables (.env)

Create a `.env` file with the credentials you want to use. For convenience an example file ` .env.example` is provided in this repo (if not, use the sample below).

Example `.env` (development):

```env
# Database
POSTGRES_DB=django_db_name
POSTGRES_USER=your_db_user
POSTGRES_PASSWORD=your_secure_password

# Django superuser (created automatically on first run)
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_PASSWORD=admin_password
DJANGO_SUPERUSER_EMAIL=admin@example.com

# Django secret key (replace for production)
DJANGO_SECRET_KEY=a_dummy_secret_key_for_dev_only

# Optional: change host/port mapping if you made adjustments to docker-compose
# DJANGO_PORT=8000
```

Security reminder: never commit `.env` to version control and always use a unique, strong `DJANGO_SECRET_KEY` in production.

## Common commands

- Start in foreground (useful for logs)

```bash
docker compose up --build
```

- Stop and remove containers

```bash
docker compose down
```

- Run Django management commands

```bash
docker compose exec web python manage.py <command>
```

- View logs (all services)

```bash
docker compose logs -f
```

## Project layout

Only the top-level structure is shown here — see the repository for full details.

- `src/` — Django project sources
  - `manage.py` — Django CLI
  - `create_superuser.py` — helper that creates superuser from env vars
  - `apps/` — application modules (e.g., `inventory`)
- `Dockerfile` — image build for the Django app
- `docker-compose.yml` & `docker-compose.override.yaml` — service definitions
- `pyproject.toml` — Python packaging / dependency metadata

## Troubleshooting

- Database connection fails on first run: wait 5-10 seconds and retry migrations. Postgres container may need a moment to initialize.
- Port conflicts: ensure nothing else is listening on port 8000 or change the port in your compose override.
- Superuser not created: verify `DJANGO_SUPERUSER_*` variables exist in `.env` and check `docker compose logs web` for errors.

## Contributing & license

Contributions welcome — open an issue or send a PR with improvements. This starter is licensed under the MIT License. See `LICENSE` (if present) for details.

---
