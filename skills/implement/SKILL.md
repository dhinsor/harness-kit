---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Before starting a ticket, check its blocking edges: only pick up a ticket whose blockers are all complete (the frontier). If the requested ticket is still blocked, say so and list the open blockers before doing anything.

If the tickets live on a tracker (e.g. Linear via MCP), update status as you go: move the ticket to the team's in-progress state when you start it, and to its done state once the work is finished and committed. For local markdown tickets (`issues/`, `TODO.md`), tick the acceptance criteria / mark it done in the file instead.

Use /tdd where possible, at pre-agreed seams.

When a ticket touches UX/UI — frontend components, layout, styling, animation, interaction, visual/empty/error states — invoke the `impeccable` skill and build to its guidance. It drives the visual and interaction quality; you still own the ticket's logic and tests. (Requires the `impeccable` skill to be installed.)

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Commit your work to the current branch.

Do not run /code-review or /spec-review as part of this skill — review is a separate, deliberate step the user runs afterward.
