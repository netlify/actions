FROM node:16-alpine

LABEL version="1.0.3"
LABEL repository="http://github.com/netlify/actions"
LABEL homepage="http://github.com/netlify/actions/netlify"
LABEL maintainer="Netlify"
LABEL "com.github.actions.name"="Netlify"
LABEL "com.github.actions.description"="Wraps the Netlify CLI to enable common Netlify commands"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="blue"

RUN npm install -g netlify-cli

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
