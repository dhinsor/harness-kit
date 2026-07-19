---
name: grill-lite
description: Interview the user about a plan or design until reaching shared understanding, using AskUserQuestion for closed questions and text for open ones. Use when user wants a fast grilling session, or mentions "grill me" and prefers tapping an answer over typing one.
---

# Grill Lite

Same goal as `/grill-me` — close every gap in understanding before you build, working through each branch of the decision tree until nothing is left open. The difference is **how you ask**: use faster UI when a question has a limited set of answers, instead of making the user type out every reply.

**Language:** run the interview — every question, option label, and message — in the language the user is working in; don't default to English just because this file is in English.

## Before asking anything

If an answer can be found by exploring the codebase or existing files, go look it up yourself. Never ask about a **fact** you can verify on your own. Ask only about **decisions** that genuinely require the user to make a call.

## Classify each question first

For every remaining gap, categorize it before you ask:

**Closed questions** — answerable by a small, well-defined set of options, 2-4 choices (pick A/B/C, yes/no, which of three approaches) → use **AskUserQuestion**
- Batch related closed questions into a single AskUserQuestion call (up to 4 questions per call). Don't fire them one question per call.
- Always list the recommended option first, with "(Recommended)" appended to its label.
- The user can pick "Other" if none of the options fit — don't strain to enumerate every possible case.

**Open questions** — require a narrative or a descriptive opinion that can't be reduced to a fixed set of options without losing meaning (e.g. "how should it feel to use this?", "walk me through the problem you're hitting") → ask as **text, one question at a time**, waiting for each answer before the next, just like `/grill-me`. Offer your recommended answer alongside the question.

An answered open question may spawn new closed questions (e.g. after a narrative reply, distill it into three options to choose from). Switch between the two modes naturally as the conversation flows — don't force them into two separate rounds.

## When to stop

Stop asking once no decision gaps remain. Don't start executing the plan until you reach that point.

Then close by proposing `/to-spec` as the next step — it turns everything just agreed into a PRD/Spec document.

## When to use another grill variant instead

- Wants a deeper, type-only conversation with no rush and no button UI → `/grill-me`
- Working on a real codebase where the understanding should accumulate in `CONTEXT.md`/ADRs for reuse later → `/grill-with-docs`
