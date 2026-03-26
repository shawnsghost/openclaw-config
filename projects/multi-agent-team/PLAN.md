# Multi-Agent Team Setup Plan

_Created: 2026-03-26_

---

## Overview

Setting up a multi-agent team for OpenClaw with specialized roles: Research, Reviewer, Coder, and Ops. Using the agent-team-orchestration skill as the framework.

---

## Team Structure

```
┌─────────────────────────────────────────────────────────┐
│  Orchestrator (main) — MiniMax-M2.7                     │
│  Route tasks, track state, synthesize, report           │
└─────────────────────────────────────────────────────────┘
          │                    │                    │
          ▼                    ▼                    ▼
   ┌─────────────┐      ┌─────────────┐      ┌─────────────┐
   │  Research   │      │  Reviewer   │      │   Coder     │
   │   Agent     │ ───► │   Agent     │ ───► │   Agent     │
   │  (Gemini)   │      │  (MiniMax)  │      │ (MiniMax)   │
   └─────────────┘      └─────────────┘      └─────────────┘
          │                    │                    │
          └────────────────────┴────────────────────┘
                    │
                    ▼
           ┌─────────────┐
           │    Ops      │
           │  (future)   │
           │   (cheap)    │
           └─────────────┘
```

---

## Workspace Structure

```
~/.openclaw/
├── agents/
│   ├── main/              # Orchestrator (current)
│   ├── research/          # Research agent workspace
│   ├── reviewer/          # Reviewer agent workspace
│   └── coder/             # Coder agent workspace
├── workspace/             # Orchestrator's workspace
├── workspace-research/    # Research agent's workspace
├── workspace-reviewer/    # Reviewer agent's workspace
├── workspace-coder/      # Coder agent's workspace
└── shared/               # Shared artifacts across agents
    ├── specs/             # Requirements and specs
    ├── artifacts/         # Build outputs
    ├── reviews/           # Review notes
    └── decisions/         # Architecture decisions
```

---

## Model Assignment

| Agent | Model | Reasoning |
|-------|-------|-----------|
| Orchestrator | MiniMax-M2.7 | High-reasoning for judgment |
| Research | Gemini (multimodal) | Web search + image analysis |
| Reviewer | MiniMax-M2.7 | Critical analysis |
| Coder | MiniMax/Gemini | Code generation |
| Ops (future) | MiniMax-M2.7 | Cheapest reliable |

---

## Agent SOUL.md Templates

### Research Agent
```markdown
# SOUL.md — Research Agent

Role: Research, web crawling, source gathering.

## Scope
- Crawl web for sources on a given topic
- Save findings to shared/specs/ with citations
- Never verify — that's the reviewer's job

## Handoff Format
1. Topic researched
2. File path to findings
3. Number of sources
4. Confidence level (high/medium/low)
```

### Reviewer Agent
```markdown
# SOUL.md — Reviewer Agent

Role: Quality assurance, fact-checking, gap analysis.

## Scope
- Review research for quality and gaps
- Flag weak sources, missing perspectives
- Never build — that's the coder's job

## Handoff Format
1. Research quality: pass/fail/major-issues
2. Gap list
3. Recommendations
```

### Coder Agent
```markdown
# SOUL.md — Coder Agent

Role: Code generation, debugging, implementation.

## Scope
- Implement features per specs
- Write tests for what you build
- Follow the handoff format exactly

## Boundaries
- Spec unclear? Ask orchestrator
- Architecture change needed? Propose only
```

---

## Task Lifecycle

```
Inbox → Assigned → In Progress → Review → Done | Failed
```

**Research Workflow Example:**
1. Orchestrator creates task: "Research OpenClaw memory plugins"
2. Spawns Research agent with task spec
3. Research agent writes to `/shared/specs/memory-research-a.md`
4. Orchestrator assigns to Reviewer
5. Reviewer approves or returns with gaps
6. If passed → task marked Done

---

## External Services

### Google (gog CLI)
- Status: Pending setup
- Services: Gmail, Calendar, Drive
- Setup: OAuth credentials needed from Shawn

### Gemini
- Status: Pending API key
- Use: Research agent (multimodal image analysis)

---

## References

- agent-team-orchestration skill: `~/.openclaw/workspace/skills/agent-team-orchestration/`
- Team setup reference: `references/team-setup.md`
- Patterns reference: `references/patterns.md`

---

_Last updated: 2026-03-26_
