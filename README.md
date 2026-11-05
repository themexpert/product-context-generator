# Product Context Generator

A Claude Code plugin (and a paste-in prompt for any other LLM) that writes a
**support-grade `<product>_context.md`**. That is one knowledge file an AI support
agent reads before answering customers about *your* product. It covers:
- "I don't get it" questions
- bugs, install and server problems
- billing, refunds and returns
- escalation and feature requests

It works for **installable software and plugins**, **SaaS**, and **hardware or consumer
products**.

The generator **reads your sources first**: website, docs, pricing, policies,
changelog, codebase, old tickets and forums. Then it **interviews you only for the
gaps**. It writes the file in a shape support agents can use:

- **Agent rules first.** Tone, scope, reply mode (direct or draft-for-a-human), what
  never to promise, when to escalate, and what to collect.
- **Symptom-first troubleshooting.** Headings use the customer's own words, then
  cause → check → fix → reply, with exact error strings.
- **Static before volatile.** Policies and playbooks first. Current version, known issues
  and outdated docs go in a dated section at the end, which you refresh each release.
- **Sourced or flagged.** Prices and policies cite their source. Anything unconfirmed is
  marked `UNVERIFIED:`, and internal-only lines are marked `(internal)`.
- **An honest status.** The header says `ready` or `draft: <reason>`, and what the
  playbook was built from.
- **No secrets, no customer data.** The skill strips them and tells you to rotate any key
  you pasted. A lint script checks the result.

## Install

### Claude Code (plugin)

In a terminal:

```bash
claude plugin marketplace add themexpert/product-context-generator
claude plugin install product-context-generator@product-context-generator
```

Or inside a Claude Code session:

```
/plugin marketplace add themexpert/product-context-generator
/plugin install product-context-generator@product-context-generator
```

Then say *"generate a support context file for my product"*, or run
`/product-context-generator:product-context`.

### Skill only (Claude Code or any Agent Skills runtime)

```bash
git clone https://github.com/themexpert/product-context-generator
cp -r product-context-generator/skills/product-context ~/.claude/skills/   # Claude Code
# Codex, Gemini CLI and Copilot CLI also read ~/.agents/skills/
```

### Any other LLM (ChatGPT, Gemini, Claude.ai)

Paste [`PROMPT.md`](PROMPT.md) as the first message and answer its questions. If the
model can browse, give it your URLs. If it can't, paste your pages in.

## What you'll be asked

1. **One round of scoping questions:** the product, the product type, your sources,
   the channels and reply mode, and where to save the file.
2. **Research:** it reads your sources.
3. **Targeted questions** in batches of four or fewer.

The most valuable answer you can give is **your top 10 real support issues and how
each is actually fixed**. See
[`questionnaire.md`](skills/product-context/questionnaire.md).

No time for an interview? Say so ("just do it"). The skill writes a `draft` file and
gives you a list of open questions, each with a recommended default.

## Output shape

The skeleton and the per-product-type variants are in
[`template.md`](skills/product-context/template.md). Worked, fictional examples:
[`acme-forms_context.md`](examples/acme-forms_context.md) (WordPress plugin) and
[`brewly-one_context.md`](examples/brewly-one_context.md) (hardware with an app).

| § | Section | Purpose |
|---|---------|---------|
| 0 | Agent rules | The only always-relevant part, ≤60 lines |
| 1–7 | Snapshot, plans, policies, requirements, glossary, lifecycle, features | Reference |
| 8 | Troubleshooting playbook | Symptom → causes → checks → fix → reply |
| 9–11 | Compatibility, customization, diagnostics | Reference |
| 12–14 | Escalation, feature requests, reply templates | Workflow |
| 15 | Volatile facts | Current version, open issues, outdated docs (dated) |
| 16 | Links | |

## Lint the result

```bash
bash skills/product-context/scripts/check-context.sh path/to/product_context.md yourcompany.com
```

The second argument is your support email domain. Separate several with commas.

**Errors** (exit code 1):
- missing core sections;
- unfilled `{{placeholders}}`;
- likely secrets: API keys, tokens, licence keys, private keys;
- personal email addresses (Gmail, Outlook and similar), which are probably customers.

**Warnings:**
- internal hostnames and private IPs;
- other unknown email addresses;
- §0 over 60 lines;
- no Status line;
- duplicate headings;
- leftover template comments;
- `UNVERIFIED` lines;
- an undated Volatile section;
- files over 1,500 lines.

To accept a confirmed false positive, append `<!-- lint-ok -->` to the line. The lint
needs `bash` and `perl`, which ship with macOS, Linux and Git for Windows.

## Using the file

- **Claude Code or other agents:** reference it from `CLAUDE.md` or `AGENTS.md` (for
  example `@yourproduct_context.md`), or load it as your support bot's system prompt.
- **Pair it with workflow skills,** for example Anthropic's official
  [`customer-support`](https://github.com/anthropics/knowledge-work-plugins) plugin
  (`ticket-triage`, `draft-response`, `customer-escalation`, `kb-article`,
  `customer-research`). Those skills supply the *workflow*; your context file supplies
  the *product knowledge*.
- **Refresh it.** Update §15 on every release. Say "refresh the context file" to re-check
  everything that changes.

## Privacy

The skill reads only the sources you name. It runs inside your own AI session and
sends nothing anywhere else. Keep the generated file private if it contains `(internal)`
lines. The `*_context.local.md` pattern is git-ignored for that purpose.

## Develop and test

```bash
bash tests/run.sh                        # lint regression tests
claude plugin validate --strict .        # manifest and directory checks
claude plugin eval . --allow-tools Write Bash -j 2   # behaviour evals, with a no-plugin baseline
```

The evals in [`evals/`](evals/) check two things:
- **Triggering:** a natural request loads the skill and opens with scoping questions.
- **Generation safety:** messy owner notes containing a fake token, a customer email,
  an internal hostname and a policy conflict produce a draft file with no leaks,
  hardware safety rules, and a handover that raises the conflict.

Keep [`PROMPT.md`](PROMPT.md) in sync with `SKILL.md` when you change the process.

## Background

This repo builds on community guidance about agent context files:

- [CLAUDE.md token and structure guide (varelser)](https://note.com/varelser/n/nf6ec3d35755b?hl=en):
  test each line with "would the agent make a mistake without it?", and put static
  content first for caching.
- [CLAUDE.md vs AGENTS.md vs MEMORY.md vs SKILLS.md vs CONTEXT.md (Amit Ray)](https://amitray.com/claude-md-vs-agents-md-memory-md-skills-md-context-md-guide-2026/):
  keep always-on rules apart from on-demand reference and volatile state.
- [claude-helpdesk (vnythakur)](https://github.com/vnythakur/claude-helpdesk): an AI
  helpdesk app whose scope docs show the inputs a support bot needs.

## License

MIT, by [ThemeXpert](https://www.themexpert.com). Built while writing the support
context for [Quix](https://www.themexpert.com/quix-pagebuilder), the Joomla page builder.
Issues and pull requests are welcome.
