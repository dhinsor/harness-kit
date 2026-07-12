Prepare a project's CLAUDE.md **right before the first line of code is written** — when the planning docs exist (spec/PRD, research, an `issues/` list) but execution hasn't started yet. The goal is to **harness the first execution phase as well as possible**: a fresh agent that opens this project should be able to start implementing the first tickets well, because CLAUDE.md tells it the stack, how to run/test, the intended architecture, the domain language, and where to read the full detail.

Think of this as **`/init` that can read documentation, not just code**. Plain `/init` bootstraps from source and goes thin when there's little code yet; `/seedling` scans the whole project — docs, code, or both — and synthesizes from whatever is actually there.

## When to use

- Planning is done (there are specs / research / tickets) but code is at zero or very thin.
- Or code exists but CLAUDE.md is missing/stale and you want a solid document before the next phase.
Either way, `/seedling` reads everything present and writes the CLAUDE.md that the executing agent will rely on.

## Process

**Language:** Conduct all interaction and write your report in the language the user is working in (check their recent messages / global config) — don't default to English just because this file is in English. (The CLAUDE.md content itself follows the project's own convention.)

### 1. Scan the whole project

Don't assume it's docs-only or code-only — look for both.

- **Planning docs**: spec / PRD (`docs/`, root), research notes, `CONTEXT.md` (domain vocabulary), any ADRs, `issues/` or `TODO.md` (the tickets about to be executed), `README`.
- **Existing CLAUDE.md seed**: read it first and treat it as ground to build on — never discard what it already states.
- **Code (if any exists)**: top-level structure, stack/config files (`package.json`, `pyproject.toml`, `Package.swift`, etc.), entry points, how it actually runs, any test setup, and the full `git log`.
- **Tracker marker**: if a spec carries a `Tracker:` line (e.g. `Tracker: Linear (project: <name>)`), note it — it belongs in the CLAUDE.md so execution routes consistently.

### 2. Synthesize CLAUDE.md

Write (or upgrade) `CLAUDE.md` from what the scan found. **Build on the existing seed if there is one** — expand and organize, don't overwrite blindly.

The rule that governs what goes in: **CLAUDE.md holds standing rules, how to run things, and pointers — NOT a copy of the specs.** The specs, research, and tickets stay in their own files; CLAUDE.md points to them and distils only the parts a fresh agent needs on every session. Never paste a PRD wholesale into it — that makes it bloated and goes stale the moment the spec changes.

**Include the sections that the project actually has something real to say about** — omit the rest rather than padding. Draw from this bank:

- **Overview** — what the project is / what this phase builds, condensed from the spec/PRD (a few sentences, not the whole doc).
- **Stack** — language, framework, key deps (chosen in the docs, or read from config if code exists).
- **Running it** — real run / build / test commands if they exist yet; otherwise `TBD — no code yet`.
- **Intended architecture** — the key modules, boundaries, and interfaces the spec's implementation decisions call for, condensed. No file paths or code snippets (they go stale) unless a snippet encodes a decision more precisely than prose (a schema, a type shape).
- **Domain vocabulary** — the project's terms, pulled from `CONTEXT.md` if present, so titles and code use the right words.
- **Conventions & standards** — the coding standards this project commits to (from docs, or observed in existing code).
- **Testing approach** — the test seam and what makes a good test here, from the spec's testing decisions. Skip if this is a playground with no tests.
- **Where things live** — pointers to the full spec/PRD, research, and `issues/`, so the executing agent knows where to read the complete detail. Include the `Tracker:` marker here if there was one.
- **Open questions / gotchas** — anything the docs left unresolved that the executor should watch for.

### 3. Tidy the project hygiene (only if missing)

- Ensure a **`.gitignore`** fitting the stack exists.
- Ensure a **`.claudeignore`** fitting the stack exists (exclude build output, deps, large assets).
- If an existing CLAUDE.md still carries an early "playground / experimental — no tests, no CI" note but the project has clearly outgrown it, remove that note.

Do NOT install dependencies or write tests here — this command only prepares the document and ignore files.

### 4. Report

Summarize briefly: what the new/upgraded CLAUDE.md now covers, and — importantly — **where information was still too thin** (e.g. "no run command yet", "deploy story unclear", "spec leaves auth undecided"), so the gaps can be closed before execution starts.

## Principles

- **CLAUDE.md = standing rules + how to run + pointers.** Not a copy of the specs; point to them, distil only what's needed every session.
- **Adapt sections to the project** — include only the ones with something real to say. A docs-only project and a half-coded one produce different documents; that's correct.
- **Build on any existing seed**, don't overwrite blindly — keep everything true that's already there.
- **Write only what's true now.** If run/build/test commands don't exist yet, say `TBD`; don't invent them. Don't guess at decisions the docs haven't made.
- **The measure of success**: a fresh agent opening this project can start the first tickets well — it knows the stack, how to run and test, the intended architecture, the domain words, and where to read the full spec and issues.
- **Respond in the language the user is working in.**
