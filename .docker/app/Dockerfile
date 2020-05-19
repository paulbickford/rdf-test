FROM elixir
LABEL maintainer="Paul Bickford"

# Non-root user to work with VSCode remotely
ARG USERNAME="vscode"
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install Debian
RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client sudo

# Add non-root user
RUN groupadd --gid ${USER_GID} ${USERNAME} \
  && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

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