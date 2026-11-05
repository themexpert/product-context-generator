# AGENTS.md

This repo ships one skill, `skills/product-context/`. It generates a support-grade
`<product>_context.md` for AI customer-support agents.

- **Entry point:** `skills/product-context/SKILL.md`. Follow its steps in order.
- **Supporting files:** `questionnaire.md` (the interview), `template.md` (output shape
  and per-product-type variants), `research.md` (mining sources), `checklist.md`
  (quality gate), and `scripts/check-context.sh` (the lint).
- **Agents without a skill system:** use `PROMPT.md`.

## Changing this repo
- Keep SKILL.md under ~200 lines.
- Keep template section numbers stable. The docs, the lint and existing users' files
  refer to them.
- When you change the process in SKILL.md, update `PROMPT.md` to match.
- Before you commit:
  - `bash tests/run.sh` must pass.
  - `claude plugin validate --strict .` must pass.
- After behaviour changes, run `claude plugin eval . --allow-tools Write Bash`.
- Examples and test fixtures use fictional products and obviously fake values
  (`*.example` domains, `FAKE` tokens). Never commit a real key or a real person's email.
