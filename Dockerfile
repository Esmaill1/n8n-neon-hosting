ARG N8N_VERSION=stable

FROM docker.n8n.io/n8nio/n8n:$N8N_VERSION

LABEL maintainer="Xiaoliang <xiaoliang.zero@gmail.com>"

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# https://huggingface.co/docs/hub/spaces-sdks-docker#permissions
# The container runs with user ID 1000.
# node docker image already has a user named node with ID 1000.
USER node

VOLUME ["$HOME/.n8n"]

# n8n default port
EXPOSE 5678

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
