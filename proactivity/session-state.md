# ~/proactivity/session-state.md

_4-field active state. Current as of last session._

---

## Current Objective

Memory system research complete (Stage 1-2 done). Ready to move toward implementation decisions.

## Last Confirmed Decision

Using OpenClaw built-in memory + QMD backend as primary path. External plugins (LanceDB, Mem0) not needed unless built-in proves inadequate.

## Blocker or Open Question

- Need to test QMD backend stability locally
- Need to verify Ollama works on VPS for local embeddings
- Autonomy model for memory filing not yet defined

## Next Useful Move

1. Test QMD backend (`memory.backend = "qmd"`) — is it stable?
2. Check if Ollama is available on VPS
3. If both work → implement dream cycle
4. If not → fall back to built-in SQLite

---

_Update this file at the start of every session. Follow "recover before asking" — read this before asking Shawn to re-explain anything._
