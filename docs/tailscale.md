# Tailscale (advanced)

For headless servers, the OmniRoute dashboard (port 20128) and OpenChamber UI
(port 3000) are normally bound to localhost. Tailscale puts your server on a
**private, encrypted network between your own devices** — so you can reach
both UIs from your phone or laptop without exposing any port to the public
internet.

This is an optional, advanced step. The core quick-start works without it.

## Install

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

Authenticate with your Tailnet when prompted.

## Verify your device is on the tailnet

```bash
tailscale status
```

Example output:

```
100.85.159.85  amp        Potowai@  linux
100.66.203.10  oneplus-15r  Potowai@  android
```

The server is now reachable at `http://<tailnet-ip>:[port]` from any of your
other Tailscale devices (phone, laptop).

## Access the UIs from your phone

OpenChamber is bound to `127.0.0.1` by default, so on the tailnet you must
bind it to the Tailscale interface. Two options:

**Option A — tailnet URL (recommended for the OpenChamber app):**

```bash
tailscale serve 3000
```

This gives you a `https://<server-hostname>.<tailnet>.ts.net` URL that
forwards to the local OpenChamber port. Open it from your phone.

**Option B — bind to the Tailscale interface directly:**

```bash
tailscale ip -4                       # get the server's tailnet IP
openchamber serve --host 0.0.0.0      # binds all interfaces; restrict with a password
omniroute --host 0.0.0.0              # OmniRoute already listens on 0.0.0.0
```

Then visit `http://<tailnet-ip>:3000` (OpenChamber) or
`http://<tailnet-ip>:20128` (OmniRoute dashboard) from your phone.

> Security note: with `--host 0.0.0.0` anything on your tailnet (and LAN) can
> reach the UIs. Prefer `tailscale serve` or add `--ui-password` /
> OmniRoute's admin password so only you can get in.

## Automating it

```bash
openchamber startup     # start OpenChamber at boot
omniroute autostart enable
```