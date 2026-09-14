# OmniRoute × OpenCode — Fast Start

Stand up a multi-provider AI gateway (OmniRoute) and point OpenCode at it,
exposing **700+ models from many providers** behind a single
OpenAI-compatible endpoint.

```bash
curl -fsSL https://raw.githubusercontent.com/Potowai/omniroute-quickstart/main/install.sh | bash
```

## What you get

| Component   | Role                                                          |
| ----------- | ------------------------------------------------------------- |
| **OmniRoute** | Local LLM gateway/router — one endpoint, many upstream providers |
| **OpenCode**  | Terminal AI coding agent                                     |

Everything talks through one local OpenAI-compatible API:
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
├── install.sh        # one-shot install of the stack
├── opencode.json     # example provider block (openai-compatible)
├── docs/
│   ├── openchamber.md   # web UI over OpenCode (advanced)
│   └── tailscale.md     # private remote access (advanced)
└── README.md
```

## Useful commands

```bash
omniroute providers list        # active connections
omniroute providers test-all    # verify connectivity
omniroute setup-opencode        # regenerate opencode model list
opencode models | grep omniroute
```

## Advanced: OpenChamber + Tailscale

OpenChamber is a web UI over OpenCode, and Tailscale gives you a private,
encrypted network between your devices so you can use the UIs from a phone or
laptop. These are optional and covered in:

- [`docs/openchamber.md`](docs/openchamber.md)
- [`docs/tailscale.md`](docs/tailscale.md)