#!/bin/sh -l

export TERM=dumb

# Build command to run netlify
read -d '' COMMAND <<- EOF
  if [ -f "\$HOME/ignore" ] && grep "^ignore:\$BUILD_DIR" "\$HOME/ignore"; then
    echo "\$BUILD_DIR didn't change"
  else
    ${BUILD_COMMAND:-echo} && netlify "$@"
  fi
EOF

# Run command and capture status
RAW_OUTPUT=$(sh -c "$COMMAND" 2>&1)
EXIT_CODE=$?

# Debug dump (optional)
echo "🪵 RAW OUTPUT:"
echo "$RAW_OUTPUT" | od -c | head -40

# Fail if command did not succeed
if [ $EXIT_CODE -ne 0 ]; then
  echo "❌ Netlify CLI command failed (exit code $EXIT_CODE)"
  echo "$RAW_OUTPUT"
  exit $EXIT_CODE
fi

# Strip ANSI escape sequences and non-printables
SANITIZED_OUTPUT=$(echo "$RAW_OUTPUT" | perl -pe 's/\e\[?.*?[\@-~]//g' | tr -cd '[:print:]\n\r')

# Debug sanitized output
echo "🪵 CLEAN OUTPUT:"
echo "$SANITIZED_OUTPUT"

# Extract values
NETLIFY_OUTPUT="$SANITIZED_OUTPUT"
NETLIFY_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*')
NETLIFY_LOGS_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*')
NETLIFY_LIVE_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -Eov "netlify.com")

# Safely write outputs
safe_output() {
  local name="$1"
  local value="$2"
  if [ -n "$value" ]; then
    echo "${name}=${value}" >> "$GITHUB_OUTPUT"
  fi
}

safe_output "NETLIFY_OUTPUT" "$NETLIFY_OUTPUT"
safe_output "NETLIFY_URL" "$NETLIFY_URL"
safe_output "NETLIFY_LOGS_URL" "$NETLIFY_LOGS_URL"
safe_output "NETLIFY_LIVE_URL" "$NETLIFY_LIVE_URL"
