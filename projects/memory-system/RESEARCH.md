# Memory System Research

_Auto-researched 2026-03-26. More to come._

---

## Executive Summary

Two plugins stand out for our use case:

1. **memory-lancedb-pro** — Vector + BM25 hybrid search, Cross-Encoder rerank, multi-scope isolation, noise filtering. TypeScript, OpenClaw-native. Best fit for local-first BM-25 goal.

2. **OpenViking** — File system paradigm, L0/L1/L2 hierarchical context loading, self-evolving skills. 17K stars, ByteDance backing. More powerful but heavier (Go + Python + C++ deps, requires VLM + embedding models).

Both require external API keys (OpenAI or compatible) for embeddings — not fully offline.

---

## Stage 1: Papers

### "Taming OpenClaw" (arXiv:2603.11619)
**Security focus.** Key threats identified:
- **Memory poisoning**: Malicious inputs get stored and influence future sessions
- **Intent drift**: Ambiguous instructions cause agent to escalate privileges unexpectedly
- **5 lifecycle stages**: initialization → input → reasoning → decision-making → execution

**Mitigation strategies from the paper:**
- Plugin signing in initialization
- Semantic firewall isolation for input
- Dynamic memory integrity checks + state rollback
- Intent consistency verification before execution
- Kernel-level sandboxing + least-privilege

**Relevance to us**: HIGH. Memory poisoning is real — we need input sanitization and memory integrity checks.

### "When OpenClaw Meets Hospital" (arXiv:2603.11721)
**Multi-agent + clinical focus.** Key ideas:
- Tree structure + manifests instead of flat vector retrieval — "progressive disclosure"
- Append-only shared documents for agent-to-agent collaboration
- Agents don't communicate directly — they subscribe to events

**Relevance to us**: MEDIUM. The tree/manifest approach for structured retrieval is interesting but clinical context is very specific.

---

## Stage 2: Plugin Deep Dives

### OpenViking (volcengine/OpenViking) — 17K+ stars

**What it is:** Context database for AI agents. File system paradigm instead of flat vector storage.

**Key features:**
- **L0/L1/L2 tiered loading**: L0 always loaded, L1 on-demand directory-level, L2 deep vector retrieval
- **File system metaphor**: memories, resources, skills unified like files in directories
- **Self-evolving skills**: Automatically distills reusable skills from memory
- **Visual retrieval traces**: Observable/debuggable context chain

**Pros:**
- Most stars of any OpenClaw memory plugin
- Hierarchical approach matches our "surgical retrieval" goal
- Self-evolving skills is unique

**Cons:**
- Heavy dependencies: Python 3.10+ Go 1.22+ C++ compiler
- Requires external API for VLM + embeddings (Volcengine, OpenAI, or LiteLLM)
- ByteDance/China-based — some may prefer not to use this
- Not purely local

**Install:** `pip install openviking`

**Config:** `~/.openviking/ov.conf` — needs API key for embeddings

---

### memory-lancedb-pro (CortexReach/memory-lancedb-pro)

**What it is:** Production-grade LanceDB hybrid retrieval plugin. Vector + BM25 + Cross-Encoder rerank.

**Key features:**
- **Hybrid retrieval**: Vector + BM25 FTS → RRF fusion → Cross-Encoder rerank
- **Multi-stage scoring**: Recency boost + importance weight + length normalization + time decay
- **MMR diversity**: Prevents near-duplicate results
- **Noise filtering**: Filters refusals, greetings, meta-questions
- **Multi-scope isolation**: global, agent:, project:, user: scopes
- **Adaptive retrieval**: Skips queries that don't need memory
- **Management CLI**: list, search, stats, delete, export, import, reembed

**Pros:**
- **Best BM-25 implementation** — exactly what we want
- Cross-Encoder reranking (Jina or custom endpoint)
- Full lifecycle hooks: before_agent_start, before_prompt_build, agent_end
- Noise filtering built in
- TypeScript/OpenClaw-native
- Tool definitions: memory_recall, memory_store, memory_forget

**Cons:**
- Still needs embedding API (OpenAI-compatible, Gemini, Jina, Ollama)
- LanceDB opaque storage (can't read memories directly like markdown)
- Complex architecture — 20+ source files

**Relevant architecture for our BM-25 goal:**
```
Query → embedQuery() ─┐
                       ├─→ RRF Fusion → Rerank → Recency Boost → Importance Weight → Filter
Query → BM25 FTS ─────┘
```

**Multi-stage scoring:**
- Recency boost: exp(-ageDays / 14) — newer wins
- Importance weight: 0.7 + 0.3 * importance
- Time decay: 0.5 + 0.5 * exp(-ageDays / 60) — older fades
- Length normalization: prevents long entries dominating
- MMR: cosine similarity > 0.85 → demoted

---

### mem9 (mem9-ai/mem9)

**What it is:** Persistent cloud memory powered by TiDB. ContextEngine hooks API.

**Key features:**
- Full lifecycle hooks: before_prompt_build, before_reset, agent_end
- "One claw one database" — per-agent isolated storage
- Memory Space web visualization at mem9.ai
- Self-hostable with TiDB/MySQL

**Pros:**
- ContextEngine integration — full lifecycle participation
- Per-agent isolation (privacy)
- MySQL/TiDB backend — can run local

**Cons:**
- Cloud service (mem9.ai) for visualization
- TiDB backend required (not pure SQLite)
- Need TiDB account or self-hosted

---

### graph-memory (adoresever/graph-memory)

**What it is:** Knowledge graph context engine. Extracts structured triples.

**Key features:**
- Structured triples instead of flat text
- 75% context compression claimed
- Cross-session experience reuse

**Cons:**
- Small/niche plugin
- Knowledge graph complexity
- Triple extraction quality depends on LLM

---

## Key Findings

### On BM-25 / Search
- **memory-lancedb-pro** has the best BM-25 implementation — RRF fusion (Vector 85% + BM25 15%), not pure BM25
- The article's recommendation of QMD + SQLite is still valid as a custom-build path
- LanceDB FTS5 is BM-25-like and embedded — could be our SQLite equivalent

### On Security ("Taming OpenClaw")
- Memory poisoning is a real threat — we need input filtering
- Don't rely on context window to filter — memories persist across sessions
- The paper recommends semantic firewall + integrity checks

### On OpenViking vs memory-lancedb-pro
- OpenViking is the "big platform" approach (17K stars, ByteDance)
- memory-lancedb-pro is the "best fit for our constraints" approach
- Both need external API keys for embeddings — neither is fully offline

---

## Open Questions (for tomorrow)

1. Can we use local embeddings (Ollama) instead of OpenAI to keep it fully local?
2. mem9 with self-hosted TiDB — is this better than LanceDB for local-first?
3. Should we build custom with SQLite FTS5 instead of using a plugin?
4. What's the actual session volume / memory load expected?

---

## TODO (Next Session)

- [ ] Read graph-memory and mem9 READMEs
- [ ] Research local embedding options (Ollama, Jina local)
- [ ] Read the LanceDB FTS5 docs — is it a BM-25 alternative?
- [ ] Check Adam Framework (5-layer, production validated)
- [ ] Start mapping plugin features to our constraints

---

_Last updated: 2026-03-26 morning_
