#!/usr/bin/env bash
set -euo pipefail

echo "==> OmniRoute + OpenCode + OpenChamber quickstart"

if ! command -v node >/dev/null 2>&1 || [[ $(node -v 2>/dev/null | grep -oE '[0-9]+' | head -1) -lt 18 ]]; then
  echo "Node.js 18+ is required (https://nodejs.org)."
  exit 1
fi

echo "==> Installing OmniRoute"
npm install -g omniroute

echo "==> Starting OmniRoute (dashboard: http://localhost:20128)"
if ! curl -sf -m 3 http://localhost:20128/api/health >/dev/null 2>&1; then
  nohup omniroute --no-open >"$HOME/.omniroute/omniroute.log" 2>&1 &
  sleep 6
fi

echo "==> Ensuring opencode is on PATH"
if ! command -v opencode >/dev/null 2>&1 && [[ -x "$HOME/.opencode/bin/opencode" ]]; then
  export PATH="$HOME/.opencode/bin:$PATH"
fi

echo
echo "==> Done. Next steps:"
echo "    1. Create an API key:  dashboard http://localhost:20128 -> Endpoints"
echo "       export OMNIROUTE_API_KEY=<sk-...>"
echo "    2. Add upstream providers:"
echo "       omniroute providers available --category api-key"
echo "       omniroute providers add <provider> --credential-stdin"
echo "    3. Register models with opencode:"
echo "       omniroute setup-opencode"
echo "    4. Use it:"
echo "       opencode -m omniroute/auto/coding \"hi\""