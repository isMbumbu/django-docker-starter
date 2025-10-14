#!/bin/sh
# entrypoint.sh — run migrations and start the dev server

echo "Applying database migrations..."
python src/manage.py migrate --noinput

echo "Starting Django server..."
python src/manage.py runserver 0.0.0.0:8000
