#!/bin/sh -l

read -d '' COMMAND <<- EOF
  if [ -f "$HOME/ignore" ] && grep "^ignore:$BUILD_DIR" "$HOME/ignore"; then
    echo "$BUILD_DIR didn't change"
  else
    ${BUILD_COMMAND:-echo} && netlify $@
  fi
EOF

echo "running ${COMMAND}"
OUTPUT=$(sh -c "$COMMAND")
echo "$OUTPUT"

NETLIFY_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*' | head -n 1)
NETLIFY_LOGS_URL=$(echo "$OUTPUT" | grep "Build logs:" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*' | head -n 1)
NETLIFY_LIVE_URL=$(echo "$OUTPUT" | grep -i "production URL:" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | head -n 1)

{
  echo "NETLIFY_URL=$NETLIFY_URL"
  echo "NETLIFY_LOGS_URL=$NETLIFY_LOGS_URL"
  echo "NETLIFY_LIVE_URL=$NETLIFY_LIVE_URL"
} >> "$GITHUB_OUTPUT"
