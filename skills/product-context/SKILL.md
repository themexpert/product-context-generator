---
name: product-context
description: >
  Interview a product owner and generate a support-grade <product>_context.md: a
  knowledge file an AI agent reads to answer customer questions, triage bugs,
  debug installs and server issues, handle billing and refund questions, and
  escalate correctly. Use when someone says "generate a context file", "context.md
  for my product", "AI support knowledge base", "teach the bot about my product",
  "support context", or wants to refresh an existing *_context.md.
---

# Product context generator

You produce one file, `<product-slug>_context.md`, that lets an AI support agent
handle real customers without guessing. Your job has two halves: **gather facts**
(read sources first, then interview the owner only for the gaps) and **write them
in the shape support agents need** (rules first, symptom-driven playbooks, volatile
facts last).

Read these alongside this file when you reach the matching step:

- `questionnaire.md`: the interview, grouped by section, with what each answer feeds.
- `template.md`: the output skeleton. Keep its order.
- `research.md`: how to mine websites, docs, code, changelogs and old tickets.
- `checklist.md`: the quality gate before you hand the file over.

## Step 1: Scope (one round of questions)

Ask, in a single round (use a multiple-choice question tool if you have one):

1. Product name, one-line description, and who buys it.
2. Every source you may read: website, pricing page, docs, support/refund policy
   pages, changelog, public or local repo path, marketplace listing, exported
   tickets/FAQ/macros, internal notes.
3. Which channels the agent will answer in (email, live chat, Discord, helpdesk)
   and whether it replies to customers directly or drafts for a human.
4. Where to save the file (default: the product repo root, else the current folder).

Do not start the full questionnaire yet. Sources answer most of it.

## Step 2: Research before you interview

Follow `research.md`. Read every source the owner gave you. For a local codebase,
delegate a broad sweep to a subagent if you can, and ask it for facts with file
paths, not code review. Build a scratch fact list where every line carries its
source (URL, file path, or "owner").

While reading, record three things separately:

- **Conflicts:** two sources disagree (a price, a requirement, a feature tier).
- **Stale sources:** docs written for an old major version still linked publicly.
- **Risks you noticed:** for example a public page leaking debug output, or docs
  telling customers to do something unsafe. Report these to the owner at the end.
  They are findings, not file content.

## Step 3: Interview only the gaps

Walk `questionnaire.md` section by section. Skip any question your research
already answered with a reliable source. For the rest:

- Ask at most 4 questions per round and group them by topic.
- Offer a recommended default whenever one exists ("Most vendors say X. Keep it?").
- Put every conflict and stale source from Step 2 to the owner as a question.
  Never resolve one by guessing.
- Ask for the owner's **top 10 real support issues** and how each one is actually
  fixed. This is the most valuable input. Push for concrete symptoms, error text,
  and fixes, not categories.
- Stop when the remaining gaps are minor. Mark them `UNVERIFIED` rather than
  dragging the interview on.

## Step 4: Write the file

Use `template.md`. Rules:

- **Agent rules go first** and stay short: tone, scope, what never to promise,
  escalation triggers, what to collect. Reference material comes after.
- **Recommend workflow skills in §0.** This file is product knowledge; triage,
  drafting and escalation come from skills. Default to Anthropic's official
  `customer-support` plugin (ticket-triage, draft-response, customer-escalation,
  kb-article, customer-research). Map each skill to the sections it should read.
- **Static before volatile.** Product facts, policies and playbooks at the top;
  current version, open known issues, promotions and stale-doc warnings in the
  final "Volatile facts" section with an "as of" date. This keeps prompt caching
  effective and makes refreshes cheap.
- **Troubleshooting is symptom-first.** Use the customer's words as headings
  ("Builder shows a blank screen"), then likely causes in probability order,
  checks, the fix, and a reply snippet. Use exact error strings so agents can match them.
- **One fact per line.** Prefer tables and short bullets over prose.
- **Every fact is sourced or owner-confirmed.** Anything else is marked
  `UNVERIFIED:` inline, or left out.
- **Separate customer-safe from internal.** Mark internal-only lines with
  `(internal)`. Agents may use them to reason, but never quote them to customers.
- **Never include secrets.** That means API keys, DSNs, passwords, license keys,
  private hostnames, customer names and emails. Point to where a human finds them.
- Drop template sections that don't apply instead of leaving them empty.
- Size: one file is fine up to ~1,500 lines. Beyond that, split into
  `context/<topic>.md` files and keep the main file as rules plus an index that
  says when to read each one.

## Step 5: Verify and hand over

1. Run `checklist.md` item by item and fix what fails.
2. If `scripts/check-context.sh` is available (it ships in this plugin's repo), run
   it on the file.
3. Show the owner a short summary:
   - sections written
   - every `UNVERIFIED` line
   - conflicts they resolved and any they left open
   - risks noticed in Step 2
4. Tell them how to use and maintain the file:
   - load it as the system/project context for the support agent, or reference it
     from CLAUDE.md / AGENTS.md
   - pair it with triage and drafting skills (for example Anthropic's
     `customer-support` plugin)
   - refresh the Volatile facts section on every release
