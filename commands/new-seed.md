Start a brand-new project **in the current working directory**, tailored by a short interview. It adapts the CLAUDE.md seed and the amount of dependencies/rules to how serious the project actually is — from a throwaway playground to a production-grade codebase. This is the single entry point for spinning up a new project.

Keep the CLAUDE.md a **seed**, not a full document — `/seedling` grows it later (before the first execution phase). Seed heavier only where the seriousness level below asks for it.

## Interview (do this first, before touching the filesystem)

**Language:** Run the entire interview — and every message to the user — in the language they're working in (check their recent messages / their global CLAUDE.md config). Don't default to English just because this command file is written in English.

If the user already gave the project name and/or description when calling the command, don't ask those again.

**Which asking method to use:** `AskUserQuestion` requires every question to have **at least 2 predefined options** — so use it ONLY for the fixed-choice questions (seriousness in step 3, tech stack in step 4). For the open-ended questions (name, description) ask as **plain text in the chat** — do NOT put them through `AskUserQuestion`, or it will error with `too_small` on empty options.

1. **Name** — ask for the project name as a **plain chat question** (not AskUserQuestion). This becomes the folder name (kebab-case it if needed).

2. **Description** — ask, as a **plain chat question**, what the project is / what it does, in a sentence or two. If they list a few features, keep them. (You can combine steps 1 and 2 into one plain message.)

3. **Seriousness** — ask with **AskUserQuestion** (single select). This is the dial that shapes everything below. **Always present all four levels below — never drop one because it seems not to fit this project.** Keeping the set fixed makes the choice predictable; if a level doesn't apply, the user simply won't pick it (and "Other" is always available). Offer these four levels, with previews:
   - **Playground** — throwaway experiment, learning, or just messing around. No tests, no CI, minimal ceremony.
   - **Weekend project** — might stick around, but it's just me. Light structure; tests only for genuinely tricky bits.
   - **Real tool** — others will use it, or I'll depend on it. Sensible standards, tests where they matter, CI-aware.
   - **Production-grade** — built to scale and stay reliable. Full discipline: tests, CI, error handling, architecture.

4. **Tech stack** — from the description + seriousness, **recommend** a stack and offer it with **AskUserQuestion** (put your recommended option first, labelled "(Recommended)"). Offer 2-3 plausible alternatives. If the description is too thin to recommend well, ask one or two clarifying questions first (e.g. "web UI or CLI?", "does it need a database?") — never guess blindly. The user can always pick "Other" and type their own.

## Build the project (after the interview)

5. Create the folder `{name}/` **in the current working directory** — wherever the user invoked the command (e.g. from their home dir → `~/{name}/`). Don't hard-code a `~/Projects/` path; if they want it somewhere specific, they can `cd` there before running this.

6. `git init`.

7. **Scaffold + install dependencies** appropriate to the chosen stack, using that stack's standard tooling — actually install so the project runs:
   - Python → `uv init` (or venv + pip); add only the deps the description clearly needs.
   - Node.js / Web → `npm init` or the framework's scaffolder (e.g. `npm create vite@latest`); install deps.
   - Swift → `swift package init` with the right type.
   - Otherwise → the idiomatic init for that stack.
   Keep it lean — install what the description calls for, not a pile of "just in case" packages. If the seriousness level is Playground, prefer the smallest possible setup (a single file is fine).

8. **Write `CLAUDE.md`** (see the seed template + how it scales below).

9. Create a **`.gitignore`** appropriate to the stack.

10. Create a **`.claudeignore`** appropriate to the stack (exclude build output, deps, lockfile noise, large assets).

11. `git add` + first commit (e.g. `chore: initial project seed`).

12. **Offer to push to GitHub — ask with `AskUserQuestion`** (single select, three fixed options); don't push automatically:
    - **Not now** — leave it local, the user can push later.
    - **Push (private)** — run `gh repo create {name} --source=. --private --push`.
    - **Push (public)** — run `gh repo create {name} --source=. --public --push`.
    If `gh` isn't authenticated, tell them and stop there.

## CLAUDE.md seed template

Keep it short and readable — a seed Claude can absorb in one pass. Always include:

- **# {Project name}** + the one-to-two-sentence description (and feature list if given).
- **## Stack** — language, framework, key deps chosen.
- **## Running it** — the real run/build/test command if known yet; otherwise write `TBD — no code yet`.
- **## Development rules** — scaled by seriousness (see below).
- **## Notes** — the seriousness tag + anything still open.

### How the seed scales with the seriousness level

Only the **Development rules** and **Notes** sections change. Draw from this bank — include more as seriousness rises, and don't include rules the level doesn't warrant (a Playground with a full test-discipline section is noise).

- **Playground**
  - Rules: keep it minimal — "move fast, no tests required, refactor only if it hurts."
  - Notes: `Playground — vibe-coded, no tests, no CI. Not built to last.`
- **Weekend project**
  - Rules: the above + "keep functions small and named clearly; add a test when logic gets tricky enough that you'd otherwise debug by hand."
  - Notes: `Weekend project — solo, light structure. May graduate later (see /seedling).`
- **Real tool**
  - Rules: "write tests for the parts others depend on (test behaviour, not implementation); keep a clear module boundary; handle the obvious error cases; commit in small, working steps."
  - Notes: `Real tool — others depend on this. Standards apply.`
- **Production-grade**
  - Rules: the Real-tool rules + "tests are expected for new behaviour (TDD where it fits); wire up CI; design for the failure cases and for scale; document non-obvious decisions as short ADRs; no unreviewed shortcuts on the critical path."
  - Notes: `Production-grade — reliability and scale matter.`

## Principles

- **Interview drives everything** — the seriousness level is the single dial that decides how heavy the seed, the deps, and the rules are. Respect it; don't over-engineer a playground or under-serve a production project.
- **Seed, not encyclopedia** — CLAUDE.md stays short. It records standing rules and how to run things, NOT specs/PRDs/feature knowledge (those live in their own docs). `/seedling` expands it later, before the first execution phase.
- **Write only what's true now** — if run/build/test commands don't exist yet, say `TBD`, don't invent them.
- **Respond in the language the user is working in** (the CLAUDE.md content itself can follow the project's convention).
