#!/bin/sh -l

# Build the command
read -d '' COMMAND <<- EOF
  if [ -f "$HOME/ignore" ] && grep "^ignore:$BUILD_DIR" "$HOME/ignore"; then
    echo "$BUILD_DIR didn't change"
  else
    ${BUILD_COMMAND:-echo} && netlify "$@"
  fi
EOF

# Execute the command and capture output
OUTPUT=$(sh -c "$COMMAND")

# Extract values using grep patterns
NETLIFY_OUTPUT=$(echo "$OUTPUT")
NETLIFY_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*')
NETLIFY_LOGS_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*')
NETLIFY_LIVE_URL=$(echo "$OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -Eov "netlify.com")

# Function to safely write outputs
safe_output() {
  local name="$1"
  local value="$2"

  # Strip control characters (e.g., zero-width space)
  value=$(echo "$value" | tr -cd '[:print:]\n\r')

  if [ -n "$value" ]; then
    echo "${name}=${value}" >> "$GITHUB_OUTPUT"
  fi
}

# Optional debugging (uncomment to inspect)
# echo "==== RAW OUTPUT ===="
# echo "$OUTPUT"
# echo "==== DEBUG OUTPUTS ===="
# echo "NETLIFY_OUTPUT: $(echo "$NETLIFY_OUTPUT" | od -c)"
# echo "NETLIFY_URL: $(echo "$NETLIFY_URL" | od -c)"
# echo "NETLIFY_LOGS_URL: $(echo "$NETLIFY_LOGS_URL" | od -c)"
# echo "NETLIFY_LIVE_URL: $(echo "$NETLIFY_LIVE_URL" | od -c)"

# Write outputs
safe_output "NETLIFY_OUTPUT" "$NETLIFY_OUTPUT"
safe_output "NETLIFY_URL" "$NETLIFY_URL"
safe_output "NETLIFY_LOGS_URL" "$NETLIFY_LOGS_URL"
safe_output "NETLIFY_LIVE_URL" "$NETLIFY_LIVE_URL"
