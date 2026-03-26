# Memory System Project Plan

_Project start: 2026-03-26_

---

## Overview

Building a multi-tier memory system for OpenClaw agent. Goal: persistent, searchable, accurate memory across sessions without context window bloat.

---

## File Structure

This project follows the **three-file system** from planning-with-files:

```
projects/memory-system/
├── PLAN.md       — This file. Architecture, roadmap, decisions.
├── PROGRESS.md   — Current state: phase status, session state, open questions, error log.
├── FINDINGS.md   — All research: papers, plugins, articles, key discoveries.
└── memory/       — Daily session logs (mirrors workspace memory/).
```

**Workspace-level structure** (for cross-project memory):
```
~/
├── self-improving/       — Durable learnings (corrections, preferences, repeated wins)
│   ├── memory.md         — HOT: confirmed durable rules
│   ├── corrections.md    — Recent corrections pending promotion
│   └── projects/         — Project-scoped learnings
├── proactivity/          — Active execution state
│   ├── session-state.md  — 4-field: objective, decision, blocker, next move
│   └── patterns.md       — Reusable proactive wins
└── memory/               — Daily logs + project memories
```

---

## Resources

### Articles & References
| Source | Title | Key Takeaway |
|--------|-------|-------------|
| [OpenClaw Pulse Memory Guide](https://openclawpulse.com/openclaw-memory-system-guide/) | OpenClaw Memory Architecture | Three-tier design, CONTEXT→ACTIVE, LESSONS→NOTES, memoryFlush |
| [TheClawGuy - Memory Plugin Review](https://theclawguy.substack.com/p/i-tested-every-openclaw-memory-plugin) | I Tested Every OpenClaw Memory Plugin | QMD + Obsidian + SQLite stack, dream cycle |
| [Mem0 Integration Guide](https://mem0.ai/blog/add-persistent-memory-openclaw) | Add Persistent Memory to OpenClaw | Open-source mode available, enforced capture at system layer |
| [LanceDB Blog](https://lancedb.com/blog/openclaw-lancedb-memory-layer/) | OpenClaw LanceDB Memory Layer | Vector + BM25, Cross-Encoder rerank |
| [Awesome-OpenClaw-Memory](https://github.com/sologuy/Awesome-OpenClaw-Memory) | Curated Memory List | 2 papers, 24 systems, 8 OpenClaw plugins |

### Official Docs
| Doc | What It Covers |
|-----|---------------|
| [docs.openclaw.ai/concepts/memory](https://docs.openclaw.ai/concepts/memory) | Built-in memory system, memoryFlush |
| [docs.openclaw.ai/reference/memory-config](https://docs.openclaw.ai/reference/memory-config) | Full config: embeddings, QMD backend, hybrid search |
| [docs.openclaw.ai/concepts/context-engine](https://docs.openclaw.ai/concepts/context-engine) | Pluggable context assembly, custom engines |
| [docs.openclaw.ai/concepts/multi-agent](https://docs.openclaw.ai/concepts/multi-agent) | Multiple isolated agents, bindings |

### Skills (from ClawHub)
| Skill | What It Offers |
|-------|---------------|
| [planning-with-files](https://clawhub.ai/othmanadi/planning-with-files) | 3-file system (PLAN/PROGRESS/FINDINGS), 2-action rule, 5Q reboot test |
| [self-improving-proactive-agent](https://clawhub.ai/yueyanc/self-improving-proactive-agent) | HOT/WARM/ARCHIVE decay, 4-field session state, recover before asking |

---

## Architecture

### Three-Tier Design

```
Tier 1 — Episodic (Daily Logs)
├── memory/YYYY-MM-DD.md — raw session logs
└── Purpose: what happened each day

Tier 2 — Semantic (Distilled Facts)
├── MEMORY.md — curated long-term facts
├── ~/self-improving/memory.md — HOT durable rules
└── Purpose: what I know, organized

Tier 3 — Procedural (How To)
├── LESSONS.md → ~/proactivity/patterns.md
├── TOOLS.md — tool notes and quirks
└── Purpose: how to behave, what went wrong
```

### Storage Roadmap

| Phase | Approach | Status |
|-------|----------|--------|
| **1** | File-based (markdown) — daily logs, memoryFlush | ✅ Active |
| **2** | SQLite — structured queries, tagging | 🔜 Planned |
| **3** | BM-25 / FTS5 — full-text ranked search | 🔜 Planned |
| **4** | Dream cycle — nightly auto-consolidation | 🔜 Planned |

---

## Key Patterns Adopted

### From planning-with-files
- **3-file system**: PLAN / PROGRESS / FINDINGS
- **2-action rule**: After every 2 web/search ops, save findings immediately
- **5-question reboot test**: Where am I / going / goal / learned / done
- **Error tracking table**: Log every error with attempt # and resolution

### From self-improving-proactive-agent
- **4-field session state**: objective / decision / blocker / next move
- **HOT/WARM/ARCHIVE decay**: 3x repeat → HOT, 30 days unused → WARM, 90 days → archive
- **Recover before asking**: Read memory → session state → working buffer → ask for delta
- **Self-improving / Proactivity split**: Durable learning vs active execution state

---

## Recommended Stack (from TheClawGuy article)

```
Obsidian (human-readable layer)
    ↓
QMD (search without token bloat, MMR + temporal decay)
    ↓
SQLite (structured facts, zero hallucinations)
    ↓
Dream Cycle (2am nightly: consolidate logs → rebuild index)
```

---

## Multi-Agent Research Workflow (Template)

This project is a **template** for future multi-agent research workflows:

```
Agent 1 (Researcher) ──► Agent 2 (Reviewer) ──► Main Agent (Synthesis)
   Crawls web              Filters sources         Reviews all
   for hours               for quality            findings
   (subagent)              (subagent)             (this agent)
                                                           │
                                                           ▼
                                                   Medium/Long-term plan
                                                   added to PLAN.md
```

**Infrastructure needs (tomorrow):** new agents, LLMs, vision capability.

---

## What's Working Now

- [x] memory/ directory created
- [x] memory/2026-03-26.md — session log
- [x] ACTIVE.md — active threads (replaces CONTEXT.md)
- [x] NOTES.md — lessons (replaces LESSONS.md)
- [x] memoryFlush enabled in openclaw.json
- [x] ~/self-improving/ structure planned
- [x] ~/proactivity/ structure planned
- [x] Files pushed to GitHub

---

## Security Notes

- GitHub PAT: exposed during early pushes — regenerate
- Credentials never stored in memory files
- External content treated as untrusted — write to FINDINGS.md, not PLAN.md
- ~/self-improving/memory.md is auto-read by hooks — guard against injection

---

_Last updated: 2026-03-26_
