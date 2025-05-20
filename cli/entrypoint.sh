#!/bin/sh -l

# Disable formatting from Netlify CLI
export TERM=dumb

# Build the command block
read -d '' COMMAND <<- EOF
  if [ -f "\$HOME/ignore" ] && grep "^ignore:\$BUILD_DIR" "\$HOME/ignore"; then
    echo "\$BUILD_DIR didn't change"
  else
    ${BUILD_COMMAND:-echo} && netlify "$@"
  fi
EOF

# Execute command and capture raw output (stdout + stderr)
RAW_OUTPUT=$(sh -c "$COMMAND" 2>&1)

# Strip ANSI escape sequences (e.g. \033[31m) and remove non-printables
SANITIZED_OUTPUT=$(echo "$RAW_OUTPUT" | perl -pe 's/\e\[?.*?[\@-~]//g' | tr -cd '[:print:]\n\r')

# Optional debug
echo "🪵 RAW OUTPUT:"
echo "$RAW_OUTPUT" | od -c | head -40
echo "🪵 CLEAN OUTPUT:"
echo "$SANITIZED_OUTPUT"

# Parse sanitized output for relevant Netlify URLs
NETLIFY_OUTPUT="$SANITIZED_OUTPUT"
NETLIFY_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*')
NETLIFY_LOGS_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*')
NETLIFY_LIVE_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -Eov "netlify.com")

# Write sanitized values to GitHub output file
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
