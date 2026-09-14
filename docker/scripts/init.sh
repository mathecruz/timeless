#!/bin/bash
# Seeds the local AWS emulator (floci) with the resources the app expects.
# Runs on container start; safe to re-run because state is persisted between restarts.
set -u

ENDPOINT="http://localhost:4566"

aws --endpoint-url "$ENDPOINT" sqs create-queue --queue-name incoming-message.fifo --attributes '{"FifoQueue": "True"}'
aws --endpoint-url "$ENDPOINT" sqs create-queue --queue-name recognized-message.fifo --attributes '{"FifoQueue": "True"}'

aws --endpoint-url "$ENDPOINT" s3api head-bucket --bucket timeless-local-assets 2>/dev/null \
  || aws --endpoint-url "$ENDPOINT" s3 mb s3://timeless-local-assets
