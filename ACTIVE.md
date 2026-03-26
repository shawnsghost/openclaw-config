# ACTIVE.md — Active Threads

_This file survives context compaction. Update it when starting or finishing tasks._

---

## ✅ Memory System — IMPLEMENTED
- Ollama running with nomic-embed-text (local, no API key)
- `memorySearch.provider = "ollama"` configured
- Gateway restarted — memory: vector ready + fts ready

---

## 🤖 Multi-Agent Team Setup (Pending)
- **Project**: projects/multi-agent-team/TODO.md
- **Needed from Shawn**:
  1. Google OAuth client_secret.json (for gog CLI)
  2. Gemini API key (https://aistudio.google.com/app/apikey)
  3. Confirm which agent handles vision

---

## 🏗️ Memory System Build (DONE)
- Built-in memory configured with Ollama embeddings
- Stage 1-2 research complete
- Files: projects/memory-system/PLAN.md, PROGRESS.md, FINDINGS.md

---

## 🔐 Security Hardening (DONE)
- Password in systemd env var `OPENCLAW_GATEWAY_PASSWORD`
- GitHub PAT: exposed during early pushes — regenerate when convenient

---

## 📦 OpenClaw Config Repo
- **Repo**: https://github.com/shawnsghost/openclaw-config
- **Status**: All progress pushed

---

## 🔜 To Do
- [ ] Google services setup (gog CLI) — waiting on OAuth creds
- [ ] Gemini LLM setup — waiting on API key
- [ ] Create Research/Reviewer/Coder agents
- [ ] Test memory search with actual queries

---
