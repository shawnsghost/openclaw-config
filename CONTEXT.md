# CONTEXT.md — Active Threads

_This file survives context compaction. Update it when starting or finishing tasks._

---

## 🏗️ Memory System Build (IN PROGRESS)
- **Goal**: Design and build a multi-tier memory system (episodic → semantic → procedural)
- **Status**: Research phase — read papers and top plugins
- **Resources collected**:
  - Awesome-OpenClaw-Memory repo (curated list: 2 papers, 24 systems, 8 plugins)
  - OpenViking (17K stars, L0/L1/L2 hierarchical context)
  - memory-lancedb-pro (Vector+BM25 hybrid, Cross-Encoder rerank)
  - "Taming OpenClaw" paper (security: memory poisoning, intent drift)
  - "When OpenClaw Meets Hospital" paper (multi-agent, progressive disclosure)
- **Key findings so far**:
  - memory-lancedb-pro is best fit for our BM-25 goal
  - OpenViking is most popular but heavier + requires ByteDance account
  - Both need embedding API (OpenAI-compatible) — not fully offline
  - Security paper highlights memory poisoning as real threat
- **References**: projects/memory-system/RESEARCH.md has full details

---

## 🔐 Security Hardening (DONE)
- **Password**: moved from openclaw.json to systemd env var `OPENCLAW_GATEWAY_PASSWORD`
- **GitHub PAT**: exposed during early pushes — recommend regenerating
- **Gateway**: restarted and verified working

---

## 📦 OpenClaw Config Repo
- **Repo**: https://github.com/shawnsghost/openclaw-config
- **Last push**: research files + plan pushed

---

## 🔜 To Do (Next Session)
- [ ] Complete research: mem9, graph-memory, Adam Framework, local embeddings
- [ ] Decide: plugin-based (memory-lancedb-pro) vs custom (SQLite FTS5)
- [ ] Check if local embeddings (Ollama) work for privacy
- [ ] Define autonomy model for memory filing
- [ ] Open questions in RESEARCH.md

---
