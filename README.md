# Product Context Generator

Generate a **support-grade `<product>_context.md`**: one knowledge file that lets an
AI agent (Claude, ChatGPT, a helpdesk bot) answer customers about *your* product
correctly. It covers "I don't get it" questions, bugs, install and server issues,
billing, refunds, escalation and feature requests.

The generator **reads your sources first** (website, docs, pricing, policies,
changelog, codebase, old tickets) and then **interviews you only for the gaps**.
It writes the file in a shape that support agents can actually use:

- **Agent rules first.** Tone, scope, what never to promise, when to escalate, what to collect.
- **Symptom-first troubleshooting.** Headings use the customer's own words, followed
  by cause → check → fix → reply, with exact error strings.
- **Static before volatile.** Policies and playbooks at the top. Current version,
  known issues and outdated docs sit in a dated section at the end that you refresh on each release.
- **Sourced or flagged.** Every fact has a source or is owner-confirmed; anything
  else is marked `UNVERIFIED:`. Internal-only lines are marked `(internal)`.
- **No secrets, no customer data.** A lint script checks for both.

## Install

### Claude Code (plugin)

```bash
claude plugin marketplace add themexpert/product-context-generator
claude plugin install product-context-generator@product-context-generator
```

Then, in any project:

```
/product-context-generator:product-context
```

or just say *"generate a support context file for my product"*.

### Claude Code (skill only, no plugin)

```bash
git clone https://github.com/themexpert/product-context-generator
cp -r product-context-generator/skills/product-context ~/.claude/skills/
```

### Any other LLM (ChatGPT, Gemini, Claude.ai)

Paste [`PROMPT.md`](PROMPT.md) as the first message and answer its questions.
If the model can browse, give it your URLs. If not, paste your pages in.

## What you'll be asked

The skill asks one round of scoping questions (product, sources, channels, output path).
It reads everything, then asks targeted questions in batches of four or fewer. The most
valuable answer you can give is **your top 10 real support issues and how each is
actually fixed**. See [`skills/product-context/questionnaire.md`](skills/product-context/questionnaire.md).

## Output shape

See [`skills/product-context/template.md`](skills/product-context/template.md) and the
worked example [`examples/acme-forms_context.md`](examples/acme-forms_context.md).

| § | Section | Purpose |
|---|---------|---------|
| 0 | Agent rules | The only always-relevant part: tone, scope, never-do, escalate-when |
| 1–7 | Snapshot, licensing, policies, requirements, glossary, lifecycle, features | Reference |
| 8 | Troubleshooting playbook | Symptom → causes → checks → fix → reply |
| 9–11 | Compatibility, customization, diagnostics | Reference |
| 12–14 | Escalation, feature requests, reply templates | Workflow |
| 15 | Volatile facts | Current version, open issues, outdated docs (dated) |

## Lint the result

```bash
scripts/check-context.sh path/to/product_context.md yourcompany.com
```

The script flags missing sections, unfilled `{{placeholders}}`, likely secrets, stray email
addresses outside your domain, `UNVERIFIED` lines, and files that are too large.

## Using the file

- **Claude Code / agents:** reference it from `CLAUDE.md` or `AGENTS.md`
  (for example `@quix_context.md`), or load it as the system prompt of your support bot.
- **Pair it** with triage and drafting skills, for example Anthropic's official
  [`customer-support`](https://github.com/anthropics/knowledge-work-plugins) plugin
  (`ticket-triage`, `draft-response`, `kb-article`, `customer-escalation`). Those skills
  supply the *workflow*; your context file supplies the *product knowledge*.
- **Refresh §15** on every release. Re-run the skill with "refresh" to update the whole file.

## Background

This repo builds on community guidance about agent context files:

- [CLAUDE.md token and structure guide (varelser)](https://note.com/varelser/n/nf6ec3d35755b?hl=en):
  test each line with "would the agent make a mistake without it?"; static content first for caching.
- [CLAUDE.md vs AGENTS.md vs MEMORY.md vs SKILLS.md vs CONTEXT.md (Amit Ray)](https://amitray.com/claude-md-vs-agents-md-memory-md-skills-md-context-md-guide-2026/):
  separate always-on rules from on-demand reference and volatile state.
- [claude-helpdesk (vnythakur)](https://github.com/vnythakur/claude-helpdesk):
  an AI helpdesk app whose scope docs show the inputs a support bot needs.

None of these generate a support context file, which is the gap this project fills.

## License

MIT, by [ThemeXpert](https://www.themexpert.com). Built while writing the support context for
[Quix](https://www.themexpert.com/quix-pagebuilder), the Joomla page builder.
