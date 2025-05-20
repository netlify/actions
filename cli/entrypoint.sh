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

NETLIFY_URL=$(echo "$OUTPUT" | grep -Eo '(https?://[^ ]*--[^ ]*\.netlify\.app)')
NETLIFY_LOGS_URL=$(echo "$OUTPUT" | grep -Eo 'https://app\.netlify\.com/[^ ]*')
NETLIFY_LIVE_URL=$(echo "$OUTPUT" | grep -Eo 'https://[^ ]*\.stackql\.io')

{
  echo "NETLIFY_URL=$NETLIFY_URL"
  echo "NETLIFY_LOGS_URL=$NETLIFY_LOGS_URL"
  echo "NETLIFY_LIVE_URL=$NETLIFY_LIVE_URL"
} >> "$GITHUB_OUTPUT"
