# Tasks

Personal task register for Curiosity OS. Synced to GitHub for mobile access.

## Files

- **Active_Work.md** — the single source of truth for everything actionable. If it's not here, it's not tracked.
- **Brain_Dump.md** — capture bucket for ideas, half-thoughts, things to triage later.

## Structure (Active_Work.md)

| Section | What lives here |
|---|---|
| **Loose / Quick** | One-off tasks, no client attached |
| **Active Clients** | Current paid work. Every task has a `#due:` date |
| **Pipeline: Proposals Sent** | Waiting on decisions. Follow-ups have `#due:` dates |
| **Pipeline: Warm Leads** | Active conversations, not yet contracted |
| **Pipeline: Cold / Early** | Early-stage opportunities |
| **Waiting / On Hold** | Parked items with `#follow-up:YYYY-MM-DD` dates |
| **Recurring** | Repeating tasks with `#every:` tags |
| **Curiosity Tasks** | Business build and backlog (internal work) |
| **Done** | Completed tasks, kept for 4 weeks then pruned (history in git) |

## Tags

- `#due:2026-02-21` — task deadline. Required for all active client tasks.
- `#follow-up:2026-10-01` — check-in date for parked/waiting items.
- `#every:monday` — recurring task. Also supports `weekly`, `fortnightly`, `monthly`.

## Rules

1. **Active_Work.md is the only place tasks live.** Project files hold context, notes, deliverables. Not tasks.
2. **No undated active client tasks.** If it's in Active Clients or Pipeline, it needs a `#due:` date.
3. **Pipeline progression:** When a lead becomes a client (e.g., after a sales meeting), move it to Active Clients with dated tasks.
4. **Parking:** When something's on hold, move it to Waiting / On Hold with a `#follow-up:` date. Remove it from its original section.

## Claude Code Skills

- `/today` — daily agenda. Scans due dates, follow-ups, and recurring tasks.
- `/tidy` — archives completed tasks, flags undated items, prunes old Done sections.
- `/review` — weekly triage. Surfaces overdue, stale, and waiting items. Triages Brain Dump.

## Sync

This repo syncs via git. Claude Code pulls at session start and commits/pushes at session end. You can view and edit from your phone via GitHub.
