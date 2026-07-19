---
name: grill-with-docs
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when user wants to stress-test a plan against their project's language and documented decisions.
---

<what-to-do>

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each question before continuing.

Ask in the language the user is working in — don't default to English just because this file is in English. (The content written into CONTEXT.md and ADRs follows the project's existing convention.)

If a question can be answered by exploring the codebase, explore the codebase instead.

</what-to-do>

<supporting-info>

## Domain modeling runs alongside

This variant is `/grill-me` plus **active domain modeling**. At the start of the session, invoke the **`/domain-modeling`** skill and apply it throughout the interview — it owns:

- the file structure (`CONTEXT.md`, `docs/adr/`, `CONTEXT-MAP.md` for multi-context repos, created lazily);
- the session habits (challenge terms against the glossary, sharpen fuzzy language, stress-test with concrete scenarios, cross-reference with code, update `CONTEXT.md` inline the moment a term resolves, offer ADRs sparingly);
- the `CONTEXT-FORMAT.md` and `ADR-FORMAT.md` templates.

Don't restate its rules here — load it and follow it. It ships in the same kit as this skill, so it's always installed alongside.

</supporting-info>
