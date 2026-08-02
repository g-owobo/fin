#!/usr/bin/env bash
# Runs the Celery worker.
set -euo pipefail

export PYTHONUNBUFFERED=1

echo "==> Waiting for database..."
python manage.py wait_for_db --timeout "${DB_WAIT_TIMEOUT:-30}"

exec celery -A gowobo_py worker \
    --loglevel="${CELERY_LOG_LEVEL:-info}" \
    --concurrency="${CELERY_CONCURRENCY:-4}" \
    --logfile=-
