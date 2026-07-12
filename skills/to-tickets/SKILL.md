---
name: to-tickets
description: Break a plan, spec, or PRD into independently-grabbable tickets, each declaring its blocking edges. Routes output to local markdown or a real issue tracker. Use when the user wants to convert a plan into tickets, create implementation tickets, or break work down.
disable-model-invocation: true
---

# To Tickets

Break a plan, spec, or conversation into a set of **tickets** — **vertical slices (tracer bullets)**, each a thin but complete path through every layer from top to bottom, NOT a horizontal cut of one layer. Each ticket declares its own **blocking edges** — a ticket with no remaining blockers is the **frontier**, grabbable right now.

## Process

### 1. Gather context

Work from whatever is already in the conversation. If the user passes a reference to a spec/PRD/ticket (a number, URL, or path) as an argument, fetch it and read its full body and comments first.

### 2. Decide where the tickets go (before slicing)

**First, check the source document for a routing marker.** If a spec/PRD is in play (from the argument or the conversation) and it carries a `Tracker:` line — e.g. `Tracker: Linear (project: <name>)` — that routing decision was already made upstream by `/to-spec`. Use it and skip asking.

**If there is no marker** (no source document, or one without a `Tracker:` line), **ask the user where the tickets should go — never guess.** Present the two destinations plainly:

- **Local markdown in the project** — appended to a root `TODO.md`, or split into `issues/NNN-<name>.md` files (numbered by dependency order) when there are many.
- **A real issue tracker** (e.g. Linear via MCP) — requires the tracker's MCP to be connected; if it isn't, tell the user, and offer markdown as a fallback for now (they can move the tickets over later).

Confirm the destination once, then proceed.

### 3. Explore the codebase (if you haven't already)

Survey the current state of the code. Ticket titles and descriptions should use the project's domain glossary vocabulary, and respect the ADRs in the area you're touching.

Look for **prefactor** opportunities — reshape the code to make the implementation easier before you slice. "Make the change easy, then make the easy change."

### 4. Draft vertical slices

<vertical-slice-rules>
- Each slice cuts a narrow but **COMPLETE** path through every layer (schema, API, UI, tests where they apply) — vertical, NOT a horizontal slice of one layer
- A completed slice is demoable or verifiable on its own
- Each slice is sized to finish in a single fresh context window
- Any prefactoring (from step 3) is always done first
</vertical-slice-rules>

Give each ticket its **blocking edges** — the other tickets that must complete before it can start. A ticket with no blockers can start immediately.

**Wide refactors are the exception to vertical slicing.** A **wide refactor** is one mechanical change — rename a shared column, retype a shared symbol — whose **blast radius** fans across the whole codebase, so a single edit breaks call sites everywhere at once and no vertical slice can land green. Don't force it into a tracer bullet; sequence it as **expand → migrate → contract**:

1. **Expand**: add the new form alongside the old so nothing breaks yet.
2. **Migrate**: move the call sites over in batches sized by blast radius (per package, per directory). Each batch is its own ticket, blocked by the expand, so CI stays green batch to batch because the old form still exists.
3. **Contract**: delete the old form once no caller remains, in a ticket blocked by every migrate batch.

If even a single batch can't stay green on its own, keep the sequence but let the batches share an **integration branch** where every batch blocks a final **"integrate-and-verify"** ticket — green is promised only there.

### 5. Check with the user

Present the proposed breakdown as a numbered list. For each ticket show:

- **Name**: short descriptive name
- **Blocked by**: which other tickets (if any) must complete first
- **Deliverable**: the end-to-end behaviour this ticket makes work

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the blocking edges correct — does each ticket only depend on tickets that genuinely gate it?
- Should any tickets be merged or split further?

Iterate until the user approves.

### 6. Publish to the destination agreed in step 2

Publish in dependency order (blockers first) so each ticket's "Blocked by" can reference real numbers/identifiers.

- **Markdown** → one slice = one `issues/NNN-<name>.md` file, or one heading in `TODO.md`. Use the template below.
- **Linear** → one slice = one issue, labelled `ready-for-agent` (or the project's equivalent). Use Linear's native blocking relationship where it exists; otherwise fall back to a text field. Publish to the project named in the spec's `Tracker:` marker if there is one; otherwise ask which team/project to use.

Write ticket bodies in the conversation language.

<issue-template>
## What to build

The end-to-end behaviour this slice makes work, from the user's perspective — not a layer-by-layer implementation list. Avoid specific file paths or code snippets (they go stale fast). Exception: a snippet from a prototype that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape) — inline just the decision-rich parts and note it came from a prototype.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

- A reference to each blocking ticket, or "None — can start immediately".
</issue-template>

Do NOT close or edit any existing parent ticket.

### 7. Point at how to execute

Run the tickets one at a time with `/implement`, clearing context between tickets. Or, to let it run unattended, use **`/goal`** with a condition like "finish and commit every ticket in `issues/`" — it will grab and complete them one by one until none remain (distinct from `/loop`, which just re-runs on a timed poll).
