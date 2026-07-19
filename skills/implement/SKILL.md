---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Before starting a ticket, check its blocking edges: only pick up a ticket whose blockers are all complete (the frontier). If the requested ticket is still blocked, say so and list the open blockers before doing anything.

If the tickets live on a tracker (e.g. Linear via MCP), update status as you go: move the ticket to the team's in-progress state when you start it, and to its done state once the work is finished and committed. For local markdown tickets (`issues/`, `TODO.md`), tick the acceptance criteria / mark it done in the file instead.

Match the testing effort to what the ticket actually touches — TDD is a tool here, not a ritual:

- **Logic and behaviour others depend on** → drive /tdd at the seams the spec's Testing Decisions pre-agreed. Keep the test list bound to the ticket's acceptance criteria — don't invent extra edge-case tests the ticket didn't ask for.
- **Thin UI / presentational work** (layout, styling, animation, visual states) → no tests of its own; `impeccable` and the review stage cover its quality. Test the logic behind it, if the ticket has any.
- **The spec or CLAUDE.md declares no tests** (playground / vibe-code work) → skip /tdd entirely and just build.

When a ticket touches UX/UI — frontend components, layout, styling, animation, interaction, visual/empty/error states — invoke the `impeccable` skill and build to its guidance. It drives the visual and interaction quality; you still own the ticket's logic and tests. (Requires the `impeccable` skill to be installed.)

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Commit your work to the current branch.

Do not run /code-review or /spec-review as part of this skill — review is a separate, deliberate step the user runs afterward.

## Parallel tickets (only when the user asks)

Default is one ticket at a time. When the user asks to run several tickets in parallel:

1. **Pick safe pairs, not just unblocked ones.** Blocking edges say the logic is independent — not that the code is. Take frontier tickets and check them against the codebase: if two would touch the same files or area (a shared schema, router, navigation), run those sequentially instead and say why.
2. **One subagent per ticket, each in its own git worktree** (worktree isolation), so they can't step on each other's files. Each subagent follows this skill's rules for its own ticket — status updates, the testing lanes above, impeccable for UI work — and commits to its own branch.
3. **Merge back one branch at a time** when they finish, running the full test suite after each merge — the merge point is where parallel work gets verified together.
