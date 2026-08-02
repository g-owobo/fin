#!/usr/bin/env bash
# Simple health check that prints to stdout/stderr for docker logs parsing.
set -euo pipefail

API_URL="${API_URL:-http://localhost:8000/health}"
TIMEOUT="${TIMEOUT:-5}"
RETRIES="${RETRIES:-12}"
SLEEP="${SLEEP:-5}"

echo "$(date -Is) - checking API at $API_URL"

for i in $(seq 1 "$RETRIES"); do
  if curl --silent --fail --max-time "$TIMEOUT" "$API_URL" >/dev/null; then
    echo "$(date -Is) - OK - API reachable"
    exit 0
  fi
  echo "$(date -Is) - attempt $i/$RETRIES failed, retrying in ${SLEEP}s..."
  sleep "$SLEEP"
done

echo "$(date -Is) - API unreachable after $RETRIES attempts" >&2
exit 2
