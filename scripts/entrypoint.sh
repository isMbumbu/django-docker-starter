#!/bin/sh

# Exit immediately if a command fails
set -e

# 1. CRITICAL: Activate the Virtual Environment for Django/Python commands
. /app/.venv/bin/activate 

# Apply database migrations
echo "Running migrations..."
python src/manage.py migrate --noinput
python src/create_superuser.py || true

# Collect static files
echo "Collecting static files..."
python src/manage.py collectstatic --noinput

# Start the app
echo "Starting Gunicorn..."

exec "$@"
