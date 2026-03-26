# ACTIVE.md — Active Threads

_This file survives context compaction. Update it when starting or finishing tasks._

---

## 🏗️ Memory System Build (IN PROGRESS)
- **Status**: Research phases 1-2 done; implementation pending
- **Key discovery**: OpenClaw built-in memory has local embeddings, hybrid BM25+vector, MMR, temporal decay — may not need external plugins
- **Pattern adopted**: planning-with-files + self-improving-proactive-agent frameworks
- **Files**: projects/memory-system/PLAN.md (architecture) / PROGRESS.md (state) / FINDINGS.md (research)

---

## 🤖 Self-Improving Structure (NEW)
- **~/self-improving/memory.md** — HOT durable rules (auto-read at session start)
- **~/self-improving/corrections.md** — recent corrections pending promotion
- **~/proactivity/session-state.md** — 4-field active state (objective/decision/blocker/next)
- Pattern: recover-before-asking, HOT/WARM/ARCHIVE decay, 2-action rule

---

## 🔐 Security Hardening (DONE)
- **Password**: moved to systemd env var `OPENCLAW_GATEWAY_PASSWORD`
- **GitHub PAT**: needs regeneration (exposed during early pushes)

---

## 🔜 To Do (Next Session)
- [ ] Test QMD backend (`memory.backend = "qmd"`)
- [ ] Check if Ollama works on VPS
- [ ] Read mem9, Adam Framework
- [ ] Define dream cycle design
- [ ] Add image analysis (vision-capable LLM tomorrow)

---
