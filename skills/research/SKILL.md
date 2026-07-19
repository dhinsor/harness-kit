---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

Spin up a **background agent** to do the research, so you keep working while it reads.

Its job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not a secondary write-up of them. Follow every claim back to the source that owns it.
2. **When the question involves a technology, library, framework, or API** — check how current it is relative to what the model already believes: latest version, release notes / changelog, breaking changes or new capabilities since the knowledge cutoff. Record which version each finding applies to. (Skip this for questions that aren't about a technology.)
3. Write the findings to a single Markdown file, **in the language the user is working in**, citing each claim's source, and stamp when the research was done ("as of YYYY-MM-DD") so future readers know how fresh it is.
4. Save it where the repo already keeps such notes; match the existing convention, and if there is none, put it somewhere sensible and say where.
