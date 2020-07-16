#!/bin/bash
set -e
echo "Stopping Traps..."
pkill -9 authorized
pkill -9 pmd
echo Done
