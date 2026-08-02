#!/usr/bin/env bash
# Runs Celery beat (single replica).
set -euo pipefail

export PYTHONUNBUFFERED=1

exec celery -A gowobo_py beat \
    --loglevel="${CELERY_LOG_LEVEL:-info}" \
    --logfile=-
