# Memory System Project — PROGRESS

_Current status and active state tracking._

---

## Session State (4-Field Structure)

| Field | Value |
|-------|-------|
| **Current Objective** | Research phase — evaluating memory architecture options |
| **Last Confirmed Decision** | Using OpenClaw built-in memory + QMD backend as primary path |
| **Blocker or Open Question** | How well does built-in hybrid search perform vs memory-lancedb-pro? |
| **Next Useful Move** | Test QMD backend locally, assess stability |

---

## Phase Status

| Phase | Status | Notes |
|-------|--------|-------|
| Stage 1: Foundation (papers) | ✅ Complete | Taming OpenClaw + Hospital papers read |
| Stage 2: Plugin Deep Dives | 🔜 In Progress | OpenViking, LanceDB, Mem0 reviewed |
| Stage 3: External Frameworks | 🔜 Pending | mem9, Adam Framework, Cognee |
| Stage 4: Decision & Implementation | 🔜 Pending | |

---

## Key Decisions Made

- [x] Three-tier memory architecture (episodic → semantic → procedural)
- [x] SQLite for structured queries (Phase 2)
- [x] BM-25 / FTS5 for search (Phase 3)
- [x] OpenClaw built-in memory as foundation (not external plugins)
- [x] QMD backend as optional upgrade for advanced search
- [x] Pre-compaction memoryFlush enabled
- [x] Local embeddings (Ollama/GGUF) for privacy

---

## Open Questions

- [ ] How well does built-in hybrid search perform vs memory-lancedb-pro?
- [ ] Is QMD stable enough for production use?
- [ ] Autonomy level: autonomous filing vs on-demand?
- [ ] Primary use case: never-forget vs research vs knowledge base?
- [ ] Dream cycle design: cron-based or heartbeat-based?

---

## Error Log

| Error | Attempt | Resolution |
|-------|---------|------------|
| GitHub PAT exposed during early push | 1 | Regenerated token, sanitized openclaw.json |
| CONTEXT.md conflicted with OpenClaw docs | 1 | Renamed to ACTIVE.md |

---

## 5-Question Reboot Test

| Question | Answer |
|----------|--------|
| Where am I? | Stage 2: Plugin deep dives (OpenViking, LanceDB, Mem0 done) |
| Where am I going? | Stage 3: External frameworks, then Stage 4: implementation |
| What's the goal? | Build multi-tier memory system: episodic + semantic + procedural |
| What have I learned? | Built-in OpenClaw memory has most features we thought we needed plugins for |
| What have I done? | Researched papers, plugins, official docs; set up workspace files |

---

## Next Actions

- [ ] Test QMD backend locally (`memory.backend = "qmd"`)
- [ ] Check if Ollama works on this VPS
- [ ] Read mem9 and Adam Framework
- [ ] Define dream cycle design
- [ ] Set up ~/self-improving/ and ~/proactivity/ structure at workspace level

---

_Last updated: 2026-03-26_
