FROM node:22-alpine

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

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use shell entrypoint that preserves "$@"
ENTRYPOINT ["sh", "-c", "/entrypoint.sh \"$@\""]
