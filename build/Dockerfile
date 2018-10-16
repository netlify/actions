FROM alpine:latest

LABEL version="1.0.0"
LABEL repository="http://github.com/netlify/actions"
LABEL homepage="http://github.com/netlify/actions/netlify"
LABEL maintainer="Netlify"
LABEL "com.github.actions.name"="Netlify Build"
LABEL "com.github.actions.description"="Deploy a site to Netlify"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="blue"

RUN apk add --update curl jq && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
