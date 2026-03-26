# OpenClaw Agent Config

Configuration, personality, and workspace files for an OpenClaw AI agent running on a VPS.

## What's Here

| File | Purpose |
|------|---------|
| `SOUL.md` | Agent personality and behavioral guidelines |
| `AGENTS.md` | Workspace conventions, memory practices, heartbeat rules |
| `IDENTITY.md` | Agent identity (name, emoji, vibe) |
| `USER.md` | Info about the human (Shawn) |
| `TOOLS.md` | Local tool notes (SSH aliases, cameras, etc.) |
| `HEARTBEAT.md` | Periodic background tasks |
| `BOOTSTRAP.md` | Original setup script |
| `CONTEXT.md` | **Start here** — notes for a new AI inheriting this setup |
| `openclaw.json` | Sanitized OpenClaw config (tokens redacted) |

## Quick Start for a New AI

1. Read `CONTEXT.md` first — it has everything you need to understand this setup
2. Read `SOUL.md` and `AGENTS.md` to understand how to behave
3. Check `USER.md` for info about Shawn
4. The agent communicates primarily via **Telegram**

## Key Info

- **Platform**: OpenClaw on Linux VPS (Ubuntu/Node)
- **Model**: MiniMax-M2.7
- **Channels**: Telegram
- **Skills**: 11/50 loaded (github, weather, healthcheck, tmux, nano-pdf, etc.)
- **GitHub**: Authenticated as `shawnsghost` (PAT stored on VPS at `~/.config/gh/hosts.yml`)

## Notes for Humans

If you're setting this up fresh:
1. Install OpenClaw: `npm install -g openclaw@latest`
2. Run `openclaw onboard` for guided setup
3. Copy `openclaw.json` to `~/.openclaw/openclaw.json` and fill in the real tokens
4. Run `openclaw gateway restart`

---
`shawnsghost` / 2026-03-26
