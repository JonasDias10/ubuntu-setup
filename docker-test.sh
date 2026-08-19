#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Building sandbox image..."
docker build -f "$SCRIPT_DIR/Dockerfile.test" -t ubuntu-setup-test "$SCRIPT_DIR"

echo ""
echo "Running install.sh (all components) + verify.sh inside the container..."
echo ""
docker run --rm -i ubuntu-setup-test bash -c '
printf "7\ntester\n" | ./install.sh
echo ""
echo "=================================================="
echo " Verification"
echo "=================================================="
./verify.sh
'
