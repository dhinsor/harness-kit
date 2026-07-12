---
name: sync-docs
description: After finishing a phase of work, bring the project's docs back in line with the code that actually shipped, then close the phase out. Use when the user wants to wrap up, sync docs, update CLAUDE.md/README to match recent work, close tickets, and open a PR.
disable-model-invocation: true
---

# Sync Docs

The closing stage of the flow (**Update**) — after this phase's code is done and has passed review, **bring the docs back in line with the code that actually shipped** before you push or open a PR.

During the work, code moves a lot but the docs (CLAUDE.md, README, CONTEXT.md) usually get left behind. When they fall out of sync, the next agent or person who reads them hits docs that lie. This skill plugs that gap.

Write doc updates and summaries in the conversation language.

## What this is NOT (don't overreach)

- **Not** a from-scratch rewrite of CLAUDE.md from a thin seed stub into full docs — that is a one-time bootstrap task when a playground grows into a real project.
- **Not** a read-only status summary that leaves files untouched.
- **Not** a bug hunt or spec check — that is `/code-review` / `/spec-review`, done in the Review stage before this.

This skill's job is only: **sync just the docs that mention what changed → offer to close tickets → offer to push/PR.** Don't touch code, don't rewrite whole files.

## Steps

### 1. Find the phase start point and view the diff

Figure out where "this phase" started so you know what changed:

- If the user gives a start point (commit, branch, tag), use it.
- If not, guess from the merge-base with `main` (`git diff main...HEAD`) or the branch's first commit, then **confirm briefly with the user** that this is the range they mean.

Look at `git diff <start>...HEAD` and `git log <start>..HEAD --oneline` to see what this phase actually did.

### 2. Find the affected docs

Look only for docs that **mention what just changed** — don't sweep every file:

- `CLAUDE.md` — run/build/test commands, architecture, conventions that may have changed.
- `README.md` — usage/setup that may have changed.
- `CONTEXT.md` / `docs/adr/` — if this phase changed the domain language or conflicts with an existing ADR (don't overwrite ADRs — if a new decision reverses an old ADR, write a new ADR that supersedes it).
- Other files under `docs/` that reference the touched area.

Read the diff against the doc contents and find where the docs **no longer say what the code does**.

### 3. Update to match reality

Fix only the stale parts so they match the code that shipped.

- Write from what the **diff/code actually shows** — don't guess or invent parts that aren't there yet. If unsure, ask.
- Change only what's needed. Preserve the doc's existing structure and style. Don't rewrite the whole file.
- Summarize for the user which files and spots you changed (as "was X" → "now Y").

### 4. Offer to close tickets

Check whether any ticket/issue was completed in this phase (from commit messages referencing `#123`/`Closes #45`/a Linear id, or from `issues/`), then **offer** to close them (don't close before the user confirms), using the same routing as `/to-tickets`:

- Real team repo → close the issue on **Linear** via MCP.
- Playground → check off / close in `issues/NNN-*.md` or `TODO.md`.

### 5. Close out

1. Offer to **commit** the doc changes (a separate commit from execute/review — message says you synced docs to match the work), then **push**.
2. Ask the user whether to open a **PR** now. If yes → `gh pr create` with a summary (what this phase did) + test plan.
3. Give a short wrap-up: which docs synced, which tickets closed, anything left open or to follow up on.

## Principles

- **Code is the source of truth, docs follow code** — not the other way around.
- **Do only what's needed** — sync the stale spots, don't seize the chance to rewrite whole files.
- **Propose, don't auto-do** for closing tickets / push / PR — wait for the user to confirm.
