# LESSONS.md — What I've Learned

_Things that went wrong, patterns that work, principles to follow. Update when I learn something the hard way._

---

## Process
- Always confirm before sending external communications (emails, tweets, posts)
- When editing files, use the write/edit tools — don't just describe changes
- If a command requires elevated permissions, wait for explicit approval
- Batch similar tasks together instead of spreading across multiple sessions
- Say "remember that..." to file something durably — it works

## Technical
- Telegram: no markdown tables — use bullet lists
- Discord: wrap multiple links in <> to suppress embeds
- WhatsApp: no headers — use **bold** for emphasis
- GitHub: PAT exposed during push attempt — recommend regenerating token
- Context window: save progress to memory/YYYY-MM-DD.md when session gets heavy
- ClawHub skills are community-written — read before enabling

## OpenClaw
- `memory/` directory doesn't auto-create — must be created manually
- memoryFlush (pre-compaction write) should be enabled in openclaw.json
- Group chats do NOT load MEMORY.md — security boundary, working as intended
- SOUL.md, AGENTS.md, USER.md load at session start — keep them updated

## Personal (Shawn)
- Prefers concise responses — don't be verbose
- Likes to plan before building — don't rush implementation
- Active Telegram user — this is primary communication channel

---
