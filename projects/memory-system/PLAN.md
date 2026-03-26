# Memory System Project

_Project start: 2026-03-26_

---

## Overview

Building a multi-tier memory system for OpenClaw agent. Goal: persistent, searchable, accurate memory across sessions without context window bloat.

---

## Resources

### Curated Collections
| Source | Description |
|--------|-------------|
| [Awesome-OpenClaw-Memory](https://github.com/sologuy/Awesome-OpenClaw-Memory) | **THE** curated list — 2 papers, 24 memory systems, 8 OpenClaw plugins, Adam Framework |

### Articles & References
| Source | Title | Key Takeaway |
|--------|-------|-------------|
| [OpenClaw Pulse Memory Guide](https://openclawpulse.com/openclaw-memory-system-guide/) | OpenClaw Memory Architecture | Three-tier design (episodic/semantic/procedural), CONTEXT.md, LESSONS.md, memoryFlush |
| [TheClawGuy - Memory Plugin Review](https://theclawguy.substack.com/p/i-tested-every-openclaw-memory-plugin) | I Tested Every OpenClaw Memory Plugin | QMD + Obsidian + SQLite stack, dream cycle, Mem0/LanceDB/Graphiti tradeoffs |

### Key Papers
| Paper | What It Covers |
|-------|---------------|
| [Taming OpenClaw (arXiv:2603.11619)](https://arxiv.org/pdf/2603.11619v1) | Security threats — memory poisoning, intent drift, mitigation strategies |
| [When OpenClaw Meets Hospital (arXiv:2603.11721)](https://arxiv.org/pdf/2603.11721) | Multi-agent memory, append-only shared docs, progressive disclosure |

### OpenClaw Plugins (from Awesome list)
| Plugin | Stars | Approach |
|--------|-------|----------|
| [OpenViking](https://github.com/volcengine/OpenViking) | 17K+ | L0/L1/L2 hierarchical context, VikingDB vector search, self-evolving skills |
| [memory-lancedb-pro](https://github.com/CortexReach/memory-lancedb-pro) | - | Vector + BM25, Cross-Encoder rerank, multi-scope isolation |
| [mem9](https://github.com/mem9-ai/mem9) | - | TiDB cloud, ContextEngine hooks (full lifecycle), per-agent isolation |
| [graph-memory](https://github.com/adoresever/graph-memory) | - | Knowledge graph → structured triples, 75% context compression |
| [openclaw-supermemory](https://github.com/supermemoryai/openclaw-supermemory) | - | Cloud-based auto-recall |
| [Adam Framework](https://github.com/strangeadvancedmarketing/Adam) | - | 5-layer system, 8 months production validated |

---

## Multi-Agent Research Workflow (Template)

This project was a prototype. Future projects follow this pattern:

```
Agent 1 (Researcher) ──► Agent 2 (Reviewer) ──► Agent 3 (Main / Synthesis)
   Crawls web              Filters sources          Reviews all
   for hours               for quality              findings
   (subagent)              (subagent)              (this agent)
                                                           │
                                                           ▼
                                                   Medium/Long-term plan
                                                   added to PLAN.md
```

**Workflow stages:**
1. **Researcher agent** — Spawned subagent, crawls web for hours, saves raw findings to `projects/<name>/raw-research/`
2. **Reviewer agent** — Spawned subagent, reads and filters raw research, saves filtered findings to `projects/<name>/filtered-research/`
3. **Main agent** — Reviews all findings, synthesizes into medium/long-term plan, updates PLAN.md

**Infrastructure needs (tomorrow):**
- Vision-capable LLM for image analysis
- Additional agents/LLMs for parallel workflows
- Persistent orchestration (subagent spawning + result collection)

---

## Staged Research Plan

Research in 4 stages. Each stage builds on the last. Don't move to next stage until we have enough info to make decisions.

### Stage 1 — Foundation (Start here)
Understand what already exists in OpenClaw memory ecosystem.
- [ ] Read the 2 arXiv papers (Taming OpenClaw + Hospital paper)
- [ ] Understand the OpenClaw ContextEngine hooks API (from mem9 docs)
- [ ] Understand the 3 memory layers (Session/Interaction/Config)

### Stage 2 — Plugin Deep Dives
Focus on OpenClaw-specific plugins we can actually install.
- [ ] **OpenViking** — L0/L1/L2 hierarchical context (ByteDance, 17K stars)
- [ ] **memory-lancedb-pro** — Vector + BM25 + Cross-Encoder (what LanceDB article pointed to)
- [ ] **mem9** — ContextEngine hooks, per-agent isolation, TiDB backend
- [ ] **graph-memory** — Knowledge graph approach, 75% context compression

### Stage 3 — External Frameworks
Memory systems that integrate with OpenClaw but are not OpenClaw-specific.
- [ ] **Mem0** — The one everyone talks about (cloud, ~7¢/msg)
- [ ] **Letta** — Stateful agents, has local option
- [ ] **LangMem** — LangChain's memory module
- [ ] **Cognee** — German-made, 2023 vintage
- [ ] **Adam Framework** — 5-layer architecture, production validated 8 months

### Stage 4 — Decision & Implementation
Tie it all together with our constraints (local-first, BM-25, SQLite).
- [ ] Map each option against our constraints
- [ ] Decide: plugin-based vs custom build
- [ ] Design our own SQLite schema
- [ ] Write the dream cycle script
- [ ] Implement

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
