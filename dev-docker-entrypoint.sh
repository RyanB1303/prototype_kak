#!/bin/sh
set -e

rm -f /app/tmp/pids/server.pid
bin/rails db:migrate || bin/rails db:setup
bin/rails yarn:install
bin/rails server -b '0.0.0.0'
