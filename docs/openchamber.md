# OpenChamber

OpenChamber is a web interface for OpenCode. It manages sessions, projects,
and scheduled tasks, and it reads the same opencode config — so once
OmniRoute's `omniroute` provider is in the config, OpenChamber sees all those
models automatically (no extra setup).

## Install / start

```bash
openchamber            # start server (daemon), default port 3000
openchamber status     # check it's running
openchamber --version
```

## Useful commands

```bash
openchamber stop                    # stop the server
openchamber restart                 # restart
openchamber startup                 # launch at system startup
openchamber schedule                # manage scheduled tasks
openchamber session                 # create / inspect sessions
openchamber models                  # show default + favorite models
openchamber projects                # list configured projects
openchamber connect-url             # openchamber:// link + QR for another device
openchamber tunnel start            # expose the UI via a tunnel provider
openchamber logs                    # tail logs
```

`openchamber connect-url` prints an `openchamber://` link (and QR code) you
scan with the OpenChamber app on your phone to attach to this server.

## Locking it down

The OpenChamber UI is bound to `127.0.0.1` by default. To expose it only to
your own devices, prefer Tailscale (see `tailscale.md`) or bind to the LAN:

```bash
openchamber serve --lan             # bind 0.0.0.0 (LAN only)
openchamber serve --ui-password     # protect the browser UI with a password
```

## Picking models through OmniRoute

OpenChamber's model picker reads the same catalog as opencode, so after
`omniroute setup-opencode` you can use any `omniroute/<prefix>/<model>` —
for example `omniroute/auto/best-coding` as your primary model.