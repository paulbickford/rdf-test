#!/bin/sh

# CONTAINER_DEV flag indicates running
# remotely in VS Code if true.
CONTAINER_DEV="false"
while getopts 'd' c
do
  case $c in
    d) CONTAINER_DEV="true"
  esac
done

# Exit if a command exits with non-zero status.
set -e

echo "\nInstalling mix dependencies..."
mix do deps.get, deps.compile

echo "\nInstalling Node dependencies..."
cd assets && npm install
cd ..

while ! pg_isready -h db -U "postgres"
do
  echo "$(date) - waiting for Postgres to start..."
  sleep 1
done

echo "\nCreate and migrate database..."
mix ecto.create
mix ecto.migrate

echo $CONTAINER_DEV

if [ "$CONTAINER_DEV" = "true" ]
then
  # Keep session open for VSCODE to attach to.
  while sleep 1000; do :; done
else
  echo "\nLaunching Phoenix web server..."
  mix phx.server
fi