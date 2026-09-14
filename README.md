# OmniRoute × OpenChamber × OpenCode — Fast Start

One command to stand up a multi-provider AI gateway (OmniRoute) and point
OpenCode / OpenChamber at it, exposing **400+ models from many providers**
behind a single OpenAI-compatible endpoint.

```bash
curl -fsSL https://raw.githubusercontent.com/Potowai/omniroute-quickstart/main/install.sh | bash
```

## What you get

| Component    | Role                                                                |
| ------------ | ------------------------------------------------------------------- |
| **OmniRoute** | Local LLM gateway/router — one endpoint, many upstream providers    |
| **OpenCode**  | Terminal AI coding agent                                             |
| **OpenChamber** | Session-orchestrated agent runner that drives OpenCode            |

All three talk to each other through one local OpenAI-compatible API:
`http://localhost:20128/v1`.

## Quick start

```bash
# 1. Install the gateway
npm install -g omniroute
omniroute                          # dashboard + API on :20128

# 2. Add upstream providers (API-key ones)
omniroute providers available --category api-key
omniroute providers add openai --credential-env OPENAI_API_KEY --yes
omniroute providers add anthropic --credential-stdin   # paste key
omniroute providers test-all

# 3. Auto-generate the OpenCode provider config (~776 models)
export OMNIROUTE_API_KEY=sk-...   # key from the dashboard → Endpoints
omniroute setup-opencode

# 4. Run
opencode -m omniroute/auto/coding "hi"
```

## No-auth providers included

The catalog ships free, keyless providers out of the box — no setup:

`aihorde`, `auggie`, `opencode`, `zcode`, `cloudflare-playground`,
`codex-app-server`, `devin-cli-agentic`, `duckduckgo-web`, `felo-web`,
`theoldllm`, `uncloseai`, `veoaifree-web`.

Use them as `omniroute/<prefix>/<model>`, e.g. `omniroute/cfp/meta/llama-3.1-8b-instruct-fp8`.
Some need a local browser runtime: `npx playwright install chromium`.

## Run OmniRoute at boot

```bash
omniroute autostart enable     # systemd user service
omniroute autostart status
```

## Files

```
.
├── install.sh        # one-shot install of all three
├── opencode.json     # example provider block (openai-compatible)
└── README.md
```

## Useful commands

```bash
omniroute providers list        # active connections
omniroute providers test-all    # verify connectivity
omniroute setup-opencode        # regenerate opencode model list
opencode models | grep omniroute
```