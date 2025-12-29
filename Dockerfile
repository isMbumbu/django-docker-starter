# ==========================
# Stage 1: Builder
# ==========================
FROM python:3.13-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libpq-dev curl && \
    rm -rf /var/lib/apt/lists/*

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install uv and sync dependencies
RUN pip install uv && uv sync --frozen --no-dev

COPY src ./src

# ==========================
# Stage 2: Runtime
# ==========================
FROM python:3.13-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Copy project + venv
COPY --from=builder /app /app

# Add entrypoint script
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use entrypoint to run migrations before starting Gunicorn
ENTRYPOINT ["/entrypoint.sh"]

# Default Gunicorn command
CMD [ \
    "/app/.venv/bin/gunicorn", \
    "--chdir", \
    "/app/src", \ 
    "core.wsgi:application", \
    "--bind", "0.0.0.0:8000", \
    "--workers", \
    "3", \
    "--access-logfile", "-", \
    "--error-logfile", "-", \
    "--log-level", "debug", \
    "--access-logformat", \
    "%(h)s \"%(r)s\" %(s)s %(b)s \"%(f)s\" \"%(a)s\" **Host:%({Host}i)s XFF:%({X-Forwarded-For}i)s XFP:%({X-Forwarded-Proto}i)s**" \
    ]