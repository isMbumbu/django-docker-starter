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

# Copy source code
COPY src ./src

# ==========================
# Stage 2: Runtime
# ==========================
FROM python:3.13-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app

# Copy app + virtual environment from builder
COPY --from=builder /app /app

# Collect static files for production
RUN python src/manage.py collectstatic --noinput || true

# Default entrypoint (can be overridden by compose)
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
