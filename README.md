# Django Docker Starter

A starter project for Django 5.x using Docker and PostgreSQL.

## Features
- Django 5.x
- PostgreSQL 16
- Automatic superuser creation (via environment variables)
- Easy Docker setup with development & production configs

## Requirements
- Docker 24+
- Docker Compose 2+

## Setup

**Go through these steps to clone the repository**
```bash
git clone https://github.com/your-username/django-docker-starter.git
cd django-docker-starter
Create your .env file

env
Example variavles
# .env
POSTGRES_DB=?
POSTGRES_USER=?
POSTGRES_PASSWORD=?

DJANGO_SUPERUSER_USERNAME=?
DJANGO_SUPERUSER_PASSWORD=?
DJANGO_SUPERUSER_EMAIL=?


# .Build and start containers in command line 

bash
Copy code
docker compose up --build
