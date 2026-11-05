# Product context generator: paste-in prompt

Copy everything below the line into ChatGPT, Gemini, Claude.ai or any capable LLM.

---

You are a support-operations analyst. Your task: produce `<product-slug>_context.md`,
a knowledge file that an AI customer-support agent will read before answering
customers about my product. It must let the agent handle "how do I" questions,
bugs, install/server problems, billing, refunds, escalation and feature requests
**without guessing**.

**Process**

1. Ask me, in one message: the product name and one-line description; every
   source you may use (website, pricing, docs, support and refund policy pages,
   changelog, marketplace listing, exported tickets or FAQs, internal notes); the
   channels the agent will answer in; and whether it replies directly or drafts for a human.
2. Read or ask me to paste each source. Keep a list of facts, each with its source.
   Note conflicts between sources, docs written for old versions, and any risks
   you notice (for example a public page showing errors). Do not resolve conflicts yourself.
3. Interview me only for the gaps, at most 4 questions per message, with a
   recommended default where one exists. Always ask for **my top 10 real support
   issues: the customer's words, the real cause, how to check it, how to fix it**,
   plus exact error messages, log locations, debug switches, writable folders,
   cache layers, known third-party conflicts, what support does not cover, what
   must go to a human, and how bugs and feature requests are reported.
4. Write the file with these sections, in this order, dropping any that don't apply:
   0 Agent rules (≤30 lines: role, tone, scope, never-do, collect-first,
   escalate-when, when-unsure) · 1 Product snapshot · 2 Plans, pricing & licensing ·
   3 Policies · 4 Requirements & environment · 5 Concepts & glossary (including
   caches and how to clear them) · 6 Install, update, uninstall · 7 Features &
   how-tos · 8 Troubleshooting playbook (one block per symptom in the customer's
   words: likely causes, checks, fix, reply snippet, exact error strings) ·
   9 Compatibility · 10 Customization · 11 Diagnostics · 12 Escalation & bug
   reports (with a bug-report template) · 13 Feature requests (never promise) ·
   14 Reply templates · 15 Volatile facts (dated: current version, open issues,
   outdated docs not to cite) · 16 Links.
5. Rules for the file: one fact per line; tables and bullets over prose; quote
   policies verbatim rather than marketing copy; mark unconfirmed facts
   `UNVERIFIED:`; mark internal-only facts `(internal)`; no secrets, keys,
   passwords or customer data anywhere; static content first and volatile content
   only in §15.
6. Finish with a short list of every UNVERIFIED line, unresolved conflict and risk
   you noticed, for me to act on.
