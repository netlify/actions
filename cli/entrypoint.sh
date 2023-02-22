#!/bin/sh -l

read -d '' COMMAND <<- EOF
  if [ -f "$HOME/ignore" ] && grep "^ignore:$BUILD_DIR" "$HOME/ignore"; then
    echo "$BUILD_DIR didn't change"
  else
    ${BUILD_COMMAND:-echo} && netlify $*
  fi
EOF

OUTPUT=$(sh -c "$COMMAND")

NETLIFY_OUTPUT=$(echo "$OUTPUT")
NETLIFY_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*') #Unique key: --
NETLIFY_LOGS_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*') #Unique key: app.netlify.com
NETLIFY_LIVE_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -Eov "netlify.com") #Unique key: don't containr -- and app.netlify.com

echo "{NETLIFY_OUTPUT}={$NETLIFY_OUTPUT}" >> $GITHUB_OUTPUT
echo "{NETLIFY_URL}={$NETLIFY_URL}" >> $GITHUB_OUTPUT
echo "{NETLIFY_LOGS_URL}={$NETLIFY_LOGS_URL}" >> $GITHUB_OUTPUT
echo "{NETLIFY_LIVE_URL}={$NETLIFY_LIVE_URL}" >> $GITHUB_OUTPUT
