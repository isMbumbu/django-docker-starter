# ==========================
# Stage 1: Builder
# ==========================
FROM python:3.13-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libpq-dev curl && \
    rm -rf /var/lib/apt/lists/*

# Copy project dependency files
COPY pyproject.toml uv.lock ./

# Install uv + sync dependencies
RUN pip install uv && uv sync --frozen --no-dev

# Copy project code
COPY src ./src

# ==========================
# Stage 2: Runtime
# ==========================
FROM python:3.13-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app

# Copy built dependencies + source code from builder
COPY --from=builder /app /app

# Collect static files safely for production
RUN python src/manage.py collectstatic --noinput || true

# Default command (overridden by compose.override.yml)
CMD ["python", "src/manage.py", "runserver", "0.0.0.0:8000"]
