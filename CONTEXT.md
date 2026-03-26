# CONTEXT.md — Active Threads

_This file survives context compaction. Update it when starting or finishing tasks._

---

## 🏗️ Memory System Build (IN PROGRESS)
- **Goal**: Design and build a multi-tier memory system (episodic → semantic → procedural)
- **Status**: Architecture planned; implementation not started
- **Key decisions made**:
  - Using SQLite (not file-only) for Phase 2
  - BM-25 / FTS5 ranking for search
- **Key decisions still open**:
  - Autonomy level: autonomous filing vs on-demand
  - Primary use case: never-forget, research assistant, or knowledge base?
- **References**: memory/2026-03-26.md has full discussion

---

## 🔐 Security Hardening (DONE)
- **Password**: moved from openclaw.json to systemd env var `OPENCLAW_GATEWAY_PASSWORD`
- **Gateway**: restarted and verified working
- **GitHub PAT**: still active; consider regenerating as precaution

---

## 📦 OpenClaw Config Repo
- **Repo**: https://github.com/shawnsghost/openclaw-config
- **Last push**: just now (sanitized openclaw.json)

---

## 🔜 To Do (Next Session)
- [ ] Memory system: define autonomy model
- [ ] Memory system: choose primary use case
- [ ] SQLite schema design
- [ ] Push all memory files to GitHub

---
