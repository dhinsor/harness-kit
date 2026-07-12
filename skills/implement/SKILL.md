---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Use /tdd where possible, at pre-agreed seams.

When a ticket touches UX/UI — frontend components, layout, styling, animation, interaction, visual/empty/error states — invoke the `impeccable` skill and build to its guidance. It drives the visual and interaction quality; you still own the ticket's logic and tests. (Requires the `impeccable` skill to be installed.)

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Commit your work to the current branch.

Do not run /code-review or /spec-review as part of this skill — review is a separate, deliberate step the user runs afterward.
