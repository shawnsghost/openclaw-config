# Memory System Research

_Auto-researched 2026-03-26. Updated with official docs findings._

---

## Executive Summary

**Major finding:** OpenClaw has built-in support for almost everything we wanted to build:
- Local embeddings (Ollama, local GGUF models) — **no API key needed**
- Hybrid BM25 + vector search — **already built in**
- QMD sidecar backend — BM25 + vectors + reranking, fully local
- MMR diversity re-ranking — **already built in**
- Temporal decay — **already built in**
- Pre-compaction memory flush — **already enabled**

We may not need external plugins at all. The path forward might just be:
1. Enable QMD backend (`memory.backend = "qmd"`)
2. Configure local embeddings (Ollama or local GGUF)
3. Done.

---

## Stage 1: Papers

### "Taming OpenClaw" (arXiv:2603.11619)
**Security focus.** Key threats:
- **Memory poisoning**: Malicious inputs get stored and influence future sessions
- **Intent drift**: Ambiguous instructions cause agent to escalate privileges unexpectedly
- **5 lifecycle stages**: initialization → input → reasoning → decision-making → execution

**Mitigation strategies:**
- Plugin signing in initialization
- Semantic firewall isolation for input
- Dynamic memory integrity checks + state rollback
- Intent consistency verification before execution
- Kernel-level sandboxing + least-privilege

**Relevance**: HIGH. Memory poisoning is real.

### "When OpenClaw Meets Hospital" (arXiv:2603.11721)
**Multi-agent + clinical focus.**
- Tree structure + manifests instead of flat vector retrieval — "progressive disclosure"
- Append-only shared documents for agent-to-agent collaboration
- Agents subscribe to events rather than communicate directly

**Relevance**: MEDIUM. Interesting patterns but clinical context is specific.

---

## Stage 2: Plugin Deep Dives

### OpenViking (volcengine/OpenViking) — 17K+ stars

**What it is:** Context database. File system paradigm, L0/L1/L2 hierarchical loading.

**Key features:**
- L0/L1/L2 tiered context (always loaded / on-demand / deep vector)
- Self-evolving skills
- Visual retrieval traces

**Pros:** Most stars, hierarchical approach

**Cons:** Heavy deps (Go + Python + C++), requires ByteDance/Volcengine account

**Verdict**: Overkill for our needs. Built-in OpenClaw memory may suffice.

---

### memory-lancedb-pro (CortexReach)

**What it is:** LanceDB hybrid retrieval (Vector + BM25 + Cross-Encoder rerank).

**Key features:**
- Hybrid retrieval: Vector + BM25 → RRF fusion → Cross-Encoder rerank
- Multi-stage scoring: recency boost, importance weight, time decay, length norm
- MMR diversity, noise filtering
- Multi-scope isolation

**Pros:** Best BM-25 implementation, production-grade

**Cons:** LanceDB opaque storage, needs embedding API

**Verdict**: Excellent but may be redundant — OpenClaw built-in + QMD may do the same thing.

---

### Mem0 (@mem0/openclaw-mem0)

**What it is:** Enforced memory capture at system layer, not left to LLM discretion.

**Key insight from article:**
- Memory capture is **enforced** — not optional
- Auto-injects relevant memory **before every response**
- **Open-source mode available** — no API key needed

**The core problem it solves:**
> "Memory exists, but it is optional. The LLM decides what to save, when to search."

**Verdict**: Solves the enforcement problem. Open-source mode is a big plus.

---

## Stage 3: Official OpenClaw Built-in Capabilities (NEW!)

**Source: docs.openclaw.ai/concepts/memory + reference/memory-config**

### What's Already Built In

| Feature | Status | Notes |
|---------|--------|-------|
| Local embeddings (Ollama) | ✅ Available | `memorySearch.provider = "ollama"` |
| Local GGUF embeddings | ✅ Available | `memorySearch.provider = "local"` via node-llama-cpp |
| Hybrid BM25 + vector | ✅ Available | Built-in, not just plugin |
| MMR diversity re-ranking | ✅ Available | Post-processing feature |
| Temporal decay | ✅ Available | Built-in post-processing |
| QMD sidecar backend | ✅ Available | BM25 + vectors + reranking, fully local |
| Pre-compaction memory flush | ✅ Enabled | `memoryFlush` already in config |
| Multi-embedding providers | ✅ | OpenAI, Gemini, Voyage, Mistral, Ollama, local GGUF |

### QMD Backend (Experimental)

From the official docs:

> "Set `memory.backend = "qmd"` to swap the built-in SQLite indexer for QMD: a local-first search sidecar that combines BM25 + vectors + reranking."

**Key points:**
- Runs fully locally via Bun + node-llama-cpp
- Auto-downloads GGUF models from HuggingFace — no separate Ollama needed
- Markdown stays source of truth
- Session JSONL indexing available
- Citations support
- SQLite backend
- Installs via: `bun install -g https://github.com/tobi/qmd`
- OS: macOS + Linux, Windows via WSL2

### Local Embedding Options

1. **`memorySearch.provider = "local"`** — uses node-llama-cpp, auto-downloads GGUF from HuggingFace
2. **`memorySearch.provider = "ollama"`** — uses running Ollama daemon at `/api/embeddings`

Both are fully offline. No API key needed.

### Hybrid Search

> "Memory search supports multiple embedding providers... Hybrid search (BM25 + vector) is available for combining semantic matching with exact keyword lookups."

This is **already enabled** in OpenClaw's built-in memory.

### Memory Flush (Pre-compaction)

Already configured in our openclaw.json:
```json
compaction: {
  memoryFlush: {
    enabled: true,
    softThresholdTokens: 4000
  }
}
```

This is already working — we set it up earlier today.

---

## Updated Architecture Thinking

### Option A: Pure Built-in (No External Plugins)
```
OpenClaw built-in memory
  ├── Local embeddings (Ollama or local GGUF)
  ├── Hybrid BM25 + vector search
  ├── MMR + temporal decay
  ├── memoryFlush (pre-compaction) — already enabled
  └── QMD backend (optional upgrade)
```

**Pros:** No extra deps, fully local, officially supported
**Cons:** QMD is marked "experimental"

### Option B: Built-in + Mem0 (Open-source mode)
```
OpenClaw built-in memory (file-based)
    + 
Mem0 open-source mode (enforced capture layer)
    +
Local embeddings
```

**Pros:** Solves the "LLM doesn't save memory" problem
**Cons:** Two systems to manage

### Option C: QMD Backend
```
OpenClaw with QMD backend
  ├── QMD: BM25 + vectors + reranking (fully local)
  ├── Local GGUF embeddings via QMD's node-llama-cpp
  └── Memory files remain source of truth
```

**Pros:** Most capable search, fully local
**Cons:** QMD is experimental, Bun dependency

---

## Key Open Questions

1. **Is the built-in hybrid search good enough?** We know it exists but not how well it performs vs memory-lancedb-pro
2. **QMD stability?** Marked experimental — is it production-ready?
3. **Do we need Mem0's enforcement, or does memoryFlush + habits solve the "LLM forgets" problem?**
4. **Ollama vs local GGUF** — which embedding model works better on a VPS?

---

## Recommendations (Preliminary)

**Start with built-in:**
1. Enable `memory.backend = "qmd"` if we want the best search
2. Use local embeddings (Ollama or local GGUF)
3. Keep `memoryFlush` enabled
4. See if it's enough — probably is for our scale

**Add Mem0 only if needed:**
- If we find the LLM still isn't saving memories reliably
- Then add Mem0 open-source mode as an enforcement layer

**Skip LanceDB plugin unless:**
- QMD proves inadequate
- We need the cross-encoder reranking specifically

---

## Resources Found

| Source | URL | What It Is |
|--------|-----|------------|
| Official Memory Docs | docs.openclaw.ai/concepts/memory | Canonical source |
| Memory Config Reference | docs.openclaw.ai/reference/memory-config | Full config surface |
| Mem0 Integration Guide | mem0.ai/blog/add-persistent-memory-openclaw | Mem0 + OpenClaw setup |
| LanceDB Pro Blog | lancedb.com/blog/openclaw-memory-from-zero-to-lancedb-pro | Plugin deep dive |
| Awesome-OpenClaw-Memory | github.com/sologuy/Awesome-OpenClaw-Memory | Curated list |
| QMD (Tobi) | github.com/tobi/qmd | Local-first search sidecar |

---

## TODO (Next Session)

- [ ] Try QMD backend (`memory.backend = "qmd"`) — is it stable?
- [ ] Test local embeddings — does Ollama work on this VPS?
- [ ] Read LanceDB blog post fully (memory-lancedb-pro)
- [ ] Decide: is built-in enough, or do we need Mem0?
- [ ] Design implementation plan

---

_Last updated: 2026-03-26 afternoon_
