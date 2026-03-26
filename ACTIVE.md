# ACTIVE.md — Active Threads

_This file survives context compaction. Update it when starting or finishing tasks._

---

## 🏗️ Memory System Build (IN PROGRESS)
- **Goal**: Design and build a multi-tier memory system (episodic → semantic → procedural)
- **Status**: Research phase — major findings from official docs
- **Big revelation**: OpenClaw built-in memory has local embeddings, hybrid BM25+vector, MMR, temporal decay — may not need external plugins
- **References**: projects/memory-system/RESEARCH.md has full details

---

## 🔐 Security Hardening (DONE)
- **Password**: moved from openclaw.json to systemd env var `OPENCLAW_GATEWAY_PASSWORD`
- **GitHub PAT**: exposed during early pushes — recommend regenerating
- **Gateway**: restarted and verified working

---

## 📦 OpenClaw Config Repo
- **Repo**: https://github.com/shawnsghost/openclaw-config
- **Last push**: research update with official docs findings

---

## 🤖 Multi-Agent Workflow Pattern (NEW)
- This project is a **template** for future multi-agent research workflows
- Pattern: Researcher subagent → Reviewer subagent → Main agent synthesis
- Next project: spawn agents for parallel research on chosen topic
- **Infrastructure coming tomorrow**: new agents, LLMs, vision capability

---

## 🔜 To Do (Next Session)
- [ ] Complete research: mem9, graph-memory, Adam Framework, local embeddings
- [ ] Decide: plugin-based (memory-lancedb-pro) vs custom (SQLite FTS5)
- [ ] Check if local embeddings (Ollama) work for privacy
- [ ] Define autonomy model for memory filing
- [ ] **NEW**: Update PLAN.md with multi-agent workflow template
- [ ] **NEW**: Infrastructure plan for tomorrow's agent/LLM additions

---
