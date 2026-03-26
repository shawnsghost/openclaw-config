# ACTIVE.md — Active Threads

_This file survives context compaction. Update it when starting or finishing tasks._

---

## 🤖 Multi-Agent Team Setup (TODAY)
- **Project**: projects/multi-agent-team/TODO.md
- **Goal**: Add Research + Reviewer + Coder agents + Gemini + Google services
- **Needed from Shawn**:
  1. Google OAuth client_secret.json (for gog CLI)
  2. Gemini API key (https://aistudio.google.com/app/apikey)
  3. Confirm which agent handles vision

---

## 🏗️ Memory System Build (IN PROGRESS)
- **Status**: Research phases 1-2 done; implementation pending
- **Key discovery**: OpenClaw built-in memory has local embeddings, hybrid BM25+vector, MMR, temporal decay — may not need external plugins
- **Pattern adopted**: planning-with-files + self-improving-proactive-agent frameworks
- **Files**: projects/memory-system/PLAN.md (architecture) / PROGRESS.md (state) / FINDINGS.md (research)

---

## 🤖 Self-Improving Structure
- **~/self-improving/memory.md** — HOT durable rules (auto-read at session start)
- **~/self-improving/corrections.md** — recent corrections pending promotion
- **~/proactivity/session-state.md** — 4-field active state (objective/decision/blocker/next)
- Pattern: recover-before-asking, HOT/WARM/ARCHIVE decay, 2-action rule

---

## 🔐 Security Hardening (DONE)
- **Password**: moved to systemd env var `OPENCLAW_GATEWAY_PASSWORD`
- **GitHub PAT**: needs regeneration (exposed during early pushes)

---

## 🔜 To Do
- [ ] TODAY: Multi-agent team setup (Research + Reviewer + Coder + Gemini + Google)
- [ ] Test QMD backend (`memory.backend = "qmd"`)
- [ ] Check if Ollama works on VPS
- [ ] Define dream cycle design

---

