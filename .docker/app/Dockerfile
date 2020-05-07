FROM elixir
LABEL maintainer="Paul Bickford"

# Install Debian
RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client

# Install Phoenix
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install --yes nodejs

WORKDIR /app
EXPOSE 4000