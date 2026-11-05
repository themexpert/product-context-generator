---
name: product-context
description: >
  Use when someone wants an AI support agent or helpdesk bot to know their product:
  "generate a context file", "context.md for my product", "support knowledge base for
  AI", "teach the bot about my product", "support context", or when an existing
  *_context.md needs a refresh after a release. Works for installable software and
  plugins, SaaS, and hardware or consumer products.
---

# Product context generator

You produce one file, `<product-slug>_context.md`. An AI support agent reads it
before answering customers, so it must let that agent work without guessing.
Your job has two halves:
- **Gather facts.** Read the sources first, then interview the owner only for the gaps.
- **Write them in the shape support agents need.** Rules first, then symptom-first
  playbooks, with volatile facts last.

Supporting files, read at the step that names them:
- `questionnaire.md`: the interview.
- `template.md`: the output skeleton and section variants per product type.
- `research.md`: how to mine sources.
- `checklist.md`: the quality gate.
- `scripts/check-context.sh`: the lint.

## Step 1: Scope (one round of questions)

Ask these in a single round. Use a multiple-choice question tool if you have one.

1. The product name, a one-line description, and who buys it.
2. **Product type:** installable software or plugin, SaaS, hardware or consumer product,
   or a mix. This picks the template variants and questionnaire blocks.
3. Every source you may read: website, pricing, docs, support and refund policy
   pages, changelog, repo path, marketplace listing, exported tickets, FAQs or macros,
   and internal notes.
4. Channels (email, chat, Discord, helpdesk), and whether the agent **replies
   directly** or **drafts for a human**.
5. Where to save the file. Default: the product repo root, else the current folder.

**Owner unavailable.** You may be running in a batch, as a subagent, or the owner
says "just do it". In that case, do not stop:
- Pick defaults for 1–5 from the sources.
- Do every later step.
- Collect each question you would have asked, with your recommended default, for the
  handover in Step 5.
- Never invent an owner answer.
- For safety, refunds and escalation, never leave a gap. Write the cautious default
  (stop and unplug; send to a human), mark it `UNVERIFIED:`, and list it in the handover.

## Step 2: Research before you interview

Follow `research.md` and read every source given. For a local codebase, delegate a
broad sweep to a subagent if you can, and ask it for facts with file paths. Keep a
scratch fact list where every line carries its source.

Record these separately as you read:
- **Conflicts:** two sources disagree, for example on a price, a limit, a tier or a policy.
- **Stale or broken sources:**
  - docs for an old version;
  - old docs domains still indexed;
  - URLs that return 404.
- **Risks:** for example a page leaking debug output, a secret pasted in the owner's
  notes, or a policy page that may break consumer law. Most risks go to the owner
  at handover and stay out of the file. The exception is a risk customers ask about,
  such as a security advisory or a known data-loss bug. That one goes in §15.

## Step 3: Interview only the gaps

Walk `questionnaire.md`. Use the common blocks, plus the block for each product type.
Skip anything a reliable source already answered.

- Ask at most 4 questions per round, grouped by topic. Offer a recommended default
  ("Most vendors say X. Keep it?").
- Put every conflict from Step 2 to the owner. Never resolve one by guessing.
- Always ask for the owner's **top 10 real support issues**: the customer's words, the
  real cause, the check and the fix. This is the most valuable input.
- Stop when the remaining gaps are minor, and mark them `UNVERIFIED:`.

## Step 4: Write the file

Use `template.md` and the variants for the product type.

- **§0 Agent rules first, at most 60 lines.** Bullets only. Reference material goes later.
- **Recommend workflow skills in §0** with a table of at most 5 rows. This file holds
  product knowledge; triage, drafting and escalation come from skills. Default to
  Anthropic's official `customer-support` plugin (ticket-triage, draft-response,
  customer-escalation, kb-article, customer-research).
- **Match the reply mode.**
  - Draft mode: §0 tells the agent to open each draft with a one-line note for the
    reviewer, and to flag `ESCALATE:` when a human must act, not just approve.
  - Direct mode: §0 lists the escalation triggers.
- **Static before volatile.** Put current versions, open issues, promotions and stale-doc
  warnings in §15, with an "as of" date. Keeping them in one place keeps prompt caching
  effective and refreshes cheap.
- **Troubleshooting is symptom-first.**
  - Headings use the customer's words.
  - Each block gives the likely causes, most likely first, then checks, the fix, and a
    reply snippet.
  - Use exact error strings.
  - Write a symptom in customer words only when a ticket, forum post or owner gave it.
    If you inferred it, mark it `UNVERIFIED:`.
- **One fact per line.** Prefer tables and short bullets.
- **Source every fact.**
  - List sources in the header.
  - Cite prices, limits and policy wording inline: `(source: <URL or "owner">)`.
  - Pasted owner notes count as an owner source.
  - Your own inference is not a source. Mark it `UNVERIFIED:`.
- **Separate customer-safe from internal.** Mark internal-only lines `(internal)`.
  That includes roadmap items the owner asks the agent to keep quiet about.
- **Never include secrets or customer data.** That means API keys, tokens, licence keys,
  passwords, internal hostnames, and customer names, emails, domains and order numbers.
  - If the owner pasted one, keep the lesson ("an Eero mesh needs legacy 2.4 GHz mode"),
    not the person.
  - Report any pasted secret as a risk to rotate.
- **Write only about this product.** Your own instructions, memory or global rules
  (for example CLAUDE.md) are not product facts. Never copy them into the file.
- **Drop** template sections that don't apply instead of leaving them empty. Don't
  renumber the rest: §8 is always the playbook, so the lint, the skills and refreshes
  can find it.
- **Split above ~1,500 lines.** Move topics into `context/<topic>.md`. Keep the main file
  as rules plus an index that says when to read each topic file.

## Step 5: Verify and hand over

1. Run `checklist.md` item by item and fix what fails.
2. Run the lint, using the path relative to this skill's directory:
   `bash scripts/check-context.sh <file> <support-email-domains, comma-separated>`.
   - Fix every ERROR.
   - For a confirmed false positive, append `<!-- lint-ok -->` to that line.
3. Set the header **Status** line:
   - `ready`: no `UNVERIFIED:` on prices, refunds, support hours or escalation, and §8
     built from real tickets or owner answers.
   - `draft`: anything else, with the reason.
   If §8 came only from docs, forums or a changelog, say so in the header.
4. Show the owner a short summary:
   - sections written;
   - every open question with your recommended default (non-interactive runs);
   - every `UNVERIFIED` line;
   - conflicts resolved and open;
   - stale or broken sources;
   - risks from Step 2.
5. Tell them how to use and maintain the file:
   - load it as the support agent's system or project context, or reference it from
     CLAUDE.md or AGENTS.md;
   - pair it with Anthropic's `customer-support` plugin;
   - refresh §15 on every release.

## Refresh an existing file

When a `*_context.md` already exists:
1. Read it, then re-read only the sources that change: changelog, pricing, policies,
   known issues and docs index.
2. Update §15 and every fact that changed. Bump "Last verified".
3. Keep the section numbers.
4. Lint it, and report a diff summary (added, changed, removed) to the owner.
