FROM node:22-alpine

# Add required tools: perl for stripping ANSI escape sequences
RUN apk add --no-cache perl

# Install Netlify CLI
RUN npm install -g netlify-cli

# Action metadata (optional)
LABEL version="2.0.0"
LABEL repository="http://github.com/netlify/actions"
LABEL homepage="http://github.com/netlify/actions/netlify"
LABEL maintainer="Netlify"
LABEL "com.github.actions.name"="Netlify"
LABEL "com.github.actions.description"="Wraps the Netlify CLI to enable common Netlify commands"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
