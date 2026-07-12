---
name: to-spec
description: Turn the current conversation into a PRD or Spec document. Use after a grilling/brief session when the user wants to write up a PRD, spec, or product requirements doc. Produces a document — not tracker tickets (that is /to-tickets).
---

Turn everything discussed in this conversation into a **PRD or Spec** document — **do NOT interview the user again**. Synthesize from what you already know (usually the user has already been through `/grill-me`, `/grill-lite`, or `/grill-with-docs`; if you still see large gaps, suggest grilling first).

Write the document in the **language the user is working in** (the language of this conversation).

This is the "write the document" step — the output is **a single document**, not yet a breakdown into individual tickets (that is the job of `/to-tickets`, which comes later, after research is done).

## Process

### 1. Decide PRD or Spec

- Broad impact / multiple teams / large architectural change → **PRD**
- Small, scoped, self-contained work that doesn't affect other areas → **Spec**

Both use the same document skeleton below. They differ only in what you call it and in the depth of Implementation Decisions (a PRD usually needs more detail because it touches many places). If it isn't clear which one applies, ask the user briefly.

### 2. Choose the template

- If the user has their own template (from their workplace, a file in the project, or pasted in) → **use that as the basis**, then fill in any sections it's missing from the standard template below. Tell the user which sections you added.
- If they don't → use the standard template below.

### 3. Survey the codebase (if it exists and you haven't already)

Look at the current state of the code so the document is grounded in reality. Use the project's domain vocabulary (if there's a CONTEXT.md) and respect any ADRs in the area you're touching. If the project has no source code yet, skip this step.

### 4. (Only for work that will have automated tests) Draft the test seam

Sketch the seam(s) at which this feature will be tested. Use the highest seam possible, prefer existing seams to new ones, and the fewer seams the better (the ideal is a single one). Then check with the user that this matches what they had in mind.

Vibe-code / playground work that won't have tests → skip this step.

### 5. Write the document and save it

Write it following the template (the user's, or the standard one below), then save:

- In a project that is a git repo → `docs/prd-<feature-name>.md` or `docs/spec-<feature-name>.md`, depending on what you chose in step 1 (create the `docs` folder if it doesn't exist).
- A small playground → `PRD.md` or `SPEC.md` at the root.
- No clear project folder yet → show it in the chat to copy out, and ask where they'd like it saved.

**Do NOT** publish it to an issue tracker at this step — breaking it into tickets is the job of `/to-tickets`, which happens after research / document adjustments are done.

### 5.5 Ask whether to sync to a tracker (ask every time)

After saving the local file, **always ask** the user — with `AskUserQuestion` — whether to mirror this document up to their issue tracker as a **Project Document** (Linear is the default tracker). Ask **every time**; never decide for them or silently skip because the project "looks like" a personal playground rather than a team repo. Offer two options:

- **Sync to Linear** (recommended for team work) — copy the document up as a Linear Project Document of the relevant project, so the team can read it in Linear.
- **Keep local only** — the file in the repo is enough for now.

Then act on the answer:

- **Sync chosen + a Linear MCP is connected** → create/update the Linear Project Document in the relevant project, and add a `Tracker: Linear (project: <project-name>)` marker line near the top of the local file (update it if one is already there). `/to-tickets` reads this line to route its tickets to that same Linear project without asking again.
- **Sync chosen but no Linear (tracker) MCP is connected** → tell the user the tracker isn't connected, so it can't mirror right now; the local file stays the source of truth, and they can connect the MCP and re-run this step later. Don't add the marker.
- **Keep local only** → skip the mirror and don't add the marker (`/to-tickets` will simply ask later).

Invariants:

- **The local file is always the source of truth** — the Linear Document is only a **mirror** for people to read. `/implement` still reads from the file during execution (faster than fetching through the MCP). Whenever the document changes, re-copy over the Linear mirror.
- This is a **Project Document, NOT an issue/ticket** — so it doesn't conflict with the "don't publish tickets" rule above (breaking into tickets is still `/to-tickets`'s job).

### 6. Close: point to the next step

Briefly summarize where the document lives, then propose the next step in the flow: **research feasibility** (`/research` or plan mode + check how up-to-date the docs of the stack you're using are relative to the model's knowledge cutoff) → adjust the document if needed → `/to-tickets` to break it into smaller pieces of work.

## Standard template (use when the user has no template of their own)

<prd-template>

## Problem Statement
The problem the user is facing — told from the user's perspective.

## Solution
The solution — from the user's perspective.

## User Stories
A LONG, numbered list of user stories, extensive and covering every aspect of the feature. Format:

1. As a <actor>, I want a <feature>, so that <benefit>

<example>
1. As a mobile bank customer, I want to see the balance on my accounts, so that I can make better informed decisions about my spending
</example>

## Implementation Decisions
The implementation decisions that were agreed on, e.g. the modules to build/modify, their interfaces, architectural decisions, schema changes, API contracts, specific interactions.

Do NOT include specific file paths or code snippets — they go out of date quickly.
Exception: if a prototype produced a snippet that captures a decision more precisely than prose can (state machine, reducer, schema, type shape), inline just the decision-rich parts, with a brief note that it came from a prototype.

## Testing Decisions
(Skip if this is a playground with no tests) — what makes a good test (test external behavior, not implementation details), which modules will be tested, and any prior art already in the codebase.

## Out of Scope
The things that are out of scope for this document.

## Further Notes
Any further notes.

</prd-template>
