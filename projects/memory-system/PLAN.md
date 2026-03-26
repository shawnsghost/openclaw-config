# Memory System Project

_Project start: 2026-03-26_

---

## Overview

Building a multi-tier memory system for OpenClaw agent. Goal: persistent, searchable, accurate memory across sessions without context window bloat.

---

## Resources

### Articles & References
| Source | Title | Key Takeaway |
|--------|-------|-------------|
| [OpenClaw Pulse Memory Guide](https://openclawpulse.com/openclaw-memory-system-guide/) | OpenClaw Memory Architecture | Three-tier design (episodic/semantic/procedural), CONTEXT.md, LESSONS.md, memoryFlush |
| [TheClawGuy - Memory Plugin Review](https://theclawguy.substack.com/p/i-tested-every-openclaw-memory-plugin) | I Tested Every OpenClaw Memory Plugin | QMD + Obsidian + SQLite stack, dream cycle, Mem0/LanceDB/Graphiti tradeoffs |

### Official Docs
- [OpenClaw Skills Docs](https://docs.openclaw.ai/skills)
- [OpenClaw Workspace](https://docs.openclaw.ai/concepts/agent-workspace)

---

## Architecture (Confirmed)

### Three-Tier Design

```
Tier 1 — Episodic (Daily Logs)
├── memory/YYYY-MM-DD.md — raw session logs
└── Purpose: what happened each day

Tier 2 — Semantic (Distilled Facts)
├── MEMORY.md — curated long-term facts
├── memory/topics/ — organized by subject
└── Purpose: what I know, organized

Tier 3 — Procedural (How To)
├── LESSONS.md — patterns, mistakes, rules
├── TOOLS.md — tool notes and quirks
└── Purpose: how to behave, what went wrong
```

### Storage Roadmap

| Phase | Approach | Status |
|-------|----------|--------|
| **1** | File-based (markdown) — daily logs, MEMORY.md | ✅ Active |
| **2** | SQLite — structured queries, tagging | 🔜 Planned |
| **3** | BM-25 / FTS5 — full-text ranked search | 🔜 Planned |
| **4** | Dream cycle — nightly auto-consolidation | 🔜 Planned |

---

## The Recommended Stack (from TheClawGuy article)

```
Obsidian (human-readable layer)
    ↓
QMD (search without token bloat, MMR + temporal decay)
    ↓
SQLite (structured facts, zero hallucinations)
    ↓
Dream Cycle (2am nightly: consolidate logs → rebuild index)
```

### QMD Features
- Surgical 3-sentence extraction (not full file reads)
- **MMR** — forces diversity in search results
- **Temporal decay** — older notes fade, recent wins
- Free, local, 5-min setup

### Dream Cycle
Nightly script that:
1. Consolidates daily logs
2. Compresses old memories
3. Rebuilds QMD index
4. Wakes up agent with clean slate

---

## Key Decisions (Still Open)

| Decision | Options | Status |
|----------|---------|--------|
| Search implementation | QMD vs custom BM-25 | Open |
| Autonomy level | Autonomous filing vs on-demand | Open |
| Primary use case | Never-forget vs research vs knowledge base | Open |
| SQLite schema | Flat facts vs hierarchical tags | Open |
| Dream cycle implementation | Cron + script vs heartbeat | Open |

---

## What's Working Now

- `memory/` directory created ✅
- `memory/2026-03-26.md` — session log ✅
- `CONTEXT.md` — active threads ✅
- `LESSONS.md` — lessons learned ✅
- `memoryFlush` enabled in openclaw.json ✅
- Files pushed to GitHub ✅

---

## Next Actions

- [ ] Research QMD — how to install, configure, use
- [ ] Decide: QMD vs custom BM-25
- [ ] Design SQLite schema
- [ ] Define autonomy model (when do I file something?)
- [ ] Write dream cycle script

---

## Notes

- Shawn's GitHub PAT: regenerate as precaution (exposed during early pushes)
- Password: moved to `env:OPENCLAW_GATEWAY_PASSWORD` in systemd service ✅
- Context window: clear session when above 50%

---

_Last updated: 2026-03-26 (session start)_
