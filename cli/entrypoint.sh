#!/bin/sh -l

export TERM=dumb

# Skip if this build dir is ignored
if [ -f "$HOME/ignore" ] && grep "^ignore:$BUILD_DIR" "$HOME/ignore"; then
  echo "$BUILD_DIR didn't change"
  exit 0
fi

# Run the Netlify CLI with passed args and capture output
RAW_OUTPUT=$(netlify "$@" 2>&1)
EXIT_CODE=$?

# Debug: show raw output
echo "🪵 RAW OUTPUT:"
echo "$RAW_OUTPUT" | od -c | head -40

# Fail early if the command errored
if [ $EXIT_CODE -ne 0 ]; then
  echo "❌ Netlify CLI command failed (exit code $EXIT_CODE)"
  echo "$RAW_OUTPUT"
  exit $EXIT_CODE
fi

# Sanitize output
SANITIZED_OUTPUT=$(echo "$RAW_OUTPUT" | perl -pe 's/\e\[?.*?[\@-~]//g' | tr -cd '[:print:]\n\r')

echo "🪵 CLEAN OUTPUT:"
echo "$SANITIZED_OUTPUT"

# Parse output
NETLIFY_OUTPUT="$SANITIZED_OUTPUT"
NETLIFY_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*')
NETLIFY_LOGS_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*')
NETLIFY_LIVE_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -Eov "netlify.com")

# Output to GitHub environment
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
#!/bin/sh -l

export TERM=dumb

# Skip if this build dir is ignored
if [ -f "$HOME/ignore" ] && grep "^ignore:$BUILD_DIR" "$HOME/ignore"; then
  echo "$BUILD_DIR didn't change"
  exit 0
fi

# Run the Netlify CLI with passed args and capture output
RAW_OUTPUT=$(netlify "$@" 2>&1)
EXIT_CODE=$?

# Debug: show raw output
echo "🪵 RAW OUTPUT:"
echo "$RAW_OUTPUT" | od -c | head -40

# Fail early if the command errored
if [ $EXIT_CODE -ne 0 ]; then
  echo "❌ Netlify CLI command failed (exit code $EXIT_CODE)"
  echo "$RAW_OUTPUT"
  exit $EXIT_CODE
fi

# Sanitize output
SANITIZED_OUTPUT=$(echo "$RAW_OUTPUT" | perl -pe 's/\e\[?.*?[\@-~]//g' | tr -cd '[:print:]\n\r')

echo "🪵 CLEAN OUTPUT:"
echo "$SANITIZED_OUTPUT"

# Parse output
NETLIFY_OUTPUT="$SANITIZED_OUTPUT"
NETLIFY_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*(--)[a-zA-Z0-9./?=_-]*')
NETLIFY_LOGS_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://app.netlify.com/[a-zA-Z0-9./?=_-]*')
NETLIFY_LIVE_URL=$(echo "$SANITIZED_OUTPUT" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -Eov "netlify.com")

# Output to GitHub environment
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
