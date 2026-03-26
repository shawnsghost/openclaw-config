# Multi-Agent Team Setup — TODO

_Created: 2026-03-26_

---

## Today's Tasks

### 1. Google Services (gog CLI) — Setup
- [ ] Install `gog` CLI on VPS
- [ ] Create Google OAuth credentials (Shawn provides)
- [ ] Run `gog auth add` for Gmail + Calendar + Drive
- [ ] Test: `gog gmail search 'in:inbox' --max 5`
- [ ] **Blocker**: Needs Shawn's Google OAuth client_secret.json

### 2. Add Gemini LLM Provider
- [ ] Get Gemini API key from Shawn
- [ ] Add to openclaw.json under `providers`
- [ ] Test: `openclaw status` shows Gemini available
- [ ] Configure which agent uses which model

### 3. Create Research Agent
- [ ] Create workspace: `~/.openclaw/workspace-research/`
- [ ] Write SOUL.md (role: research, web crawling, source gathering)
- [ ] Add to `agents.list` in openclaw.json
- [ ] Model: Gemini (multimodal for image analysis during research)
- [ ] Spawn test task: verify it works

### 4. Create Reviewer Agent
- [ ] Create workspace: `~/.openclaw/workspace-reviewer/`
- [ ] Write SOUL.md (role: quality assurance, fact-checking, gap analysis)
- [ ] Add to `agents.list` in openclaw.json
- [ ] Model: MiniMax (high reasoning for critical analysis)
- [ ] Spawn test task: verify it works

### 5. Create Coding Agent
- [ ] Create workspace: `~/.openclaw/workspace-coder/`
- [ ] Write SOUL.md (role: code generation, debugging, implementation)
- [ ] Add to `agents.list` in openclaw.json
- [ ] Model: MiniMax or Gemini (coding tasks)
- [ ] Install coding-agent skill if needed
- [ ] Spawn test task: verify it works

### 6. Configure Bindings & Routing
- [ ] Set up bindings: which channel routes to which agent
- [ ] Document routing rules in ACTIVE.md

---

## What's Needed From Shawn

| Item | How to Get |
|------|-----------|
| Google OAuth client_secret.json | Go to Google Cloud Console → APIs & Services → Credentials → OAuth Client ID → Download |
| Gemini API key | https://aistudio.google.com/app/apikey |
| Vision capability confirmation | Which agent should handle image analysis? |

---

## After Setup (Tomorrow)

- [ ] Run first multi-agent workflow: memory system research
- [ ] Test handoff protocol between agents
- [ ] Set up ops agent for cron tasks
- [ ] Configure heartbeat for team health checks

---

## Agent Roles Summary

| Agent | Workspace | Model | Primary Role |
|-------|-----------|-------|-------------|
| **Orchestrator** (main) | workspace/ | MiniMax-M2.7 | Route, prioritize, synthesize |
| **Research** | workspace-research/ | Gemini | Web crawling, source gathering |
| **Reviewer** | workspace-reviewer/ | MiniMax-M2.7 | Quality assurance, gap analysis |
| **Coder** | workspace-coder/ | MiniMax/Gemini | Code generation |

---

_Last updated: 2026-03-26_
