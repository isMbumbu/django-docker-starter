# Django Docker Starter

A starter project for Django 5.x using Docker and PostgreSQL.

# Features

Django 5.x

PostgreSQL 16

Automatic superuser creation (via environment variables)

Easy Docker setup with development & production configs

Requirements

Docker 24+

Docker Compose 2+

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
POSTGRES_USER=your_db_user
POSTGRES_PASSWORD=your_secure_password

# Django Superuser Credentials (Created automatically on first run)

DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_PASSWORD=admin_password
DJANGO_SUPERUSER_EMAIL=admin@example.com

# Django Secret Key (Use a unique key in production)

DJANGO_SECRET_KEY=a_dummy_secret_key_for_dev_only

Your application should now be running!

Service Name

Default URL

Django

http://localhost:8000

Admin Panel

http://localhost:8000/admin
