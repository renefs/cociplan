FROM python:3.10-slim

WORKDIR /usr/src/app

ENV PYTHONPATH "${PYTHONPATH}:/usr/src"
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV UV_VERSION 0.5
ENV UV_COMPILE_BYTECODE 1
ENV UV_LINK_MODE copy
ENV VIRTUAL_ENVIRONMENT_PATH ${WORKDIR}/.venv

LABEL org.opencontainers.image.authors='renefernandez@duck.com' \
      org.opencontainers.image.url='https://github.com/bocabitlabs/cociplan/pkgs/container/cociplan' \
      org.opencontainers.image.source="https://github.com/bocabitlabs/cociplan" \
      org.opencontainers.image.vendor='Rene Fernandez' \
      org.opencontainers.image.licenses='GPL-3.0-or-later'

# Required to have netcat-openbsd
RUN apt-get update
RUN apt-get install default-libmysqlclient-dev netcat-openbsd gcc pkg-config -y

# Install uv and dependencies
COPY pyproject.toml ./
COPY uv.lock ./

# Install uv and use it to install dependencies
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN uv sync --frozen --no-dev --no-install-project

COPY ./backend $WORKDIR
COPY ./etc /usr/src/etc

RUN chmod +x /usr/src/etc/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/usr/src/etc/entrypoint.sh"]
