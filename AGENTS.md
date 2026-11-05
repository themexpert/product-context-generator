# AGENTS.md

This repo ships one skill: `skills/product-context/`. It generates a support-grade
`<product>_context.md` for AI customer-support agents.

- Entry point: `skills/product-context/SKILL.md`. Follow its five steps in order.
- Supporting files: `questionnaire.md` (interview), `template.md` (output shape),
  `research.md` (source mining), `checklist.md` (quality gate).
- Lint output with `scripts/check-context.sh <file> [allowed-email-domain]`.
- Agents without a skill system: use `PROMPT.md`.

Conventions for changes here: keep SKILL.md under ~150 lines, keep template section
numbers stable (the docs and lint script refer to them), and test any template
change by generating `examples/acme-forms_context.md` again and linting it.
