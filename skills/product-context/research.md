# Research before you interview

Owners forget what their own website says, and websites forget what the product
does now. Read everything, keep a source next to every fact, and bring the
disagreements back to the owner.

## Websites and docs
- Product, pricing, support, refund-policy, terms, changelog and docs index pages.
- Copy policy wording **verbatim**. Marketing copy ("no questions asked") and the
  actual policy often differ. The policy wins, and the difference is a question for the owner.
- In docs, check each article's version. An article for an old major version
  that is still linked from the docs index belongs in "outdated docs not to cite".
- Marketplace listings (app stores, extension directories): note status, rating,
  and whether the listing is still published.
- If a fetch returns debug output, errors or a login wall, record that as a
  risk for the owner instead of retrying it forever.

## Codebase (if you have it)
Send a subagent with a narrow, fact-finding brief. Ask for file paths with every fact:
- Version numbers and supported platform versions (manifests, package files).
- Install/requirement checks (version_compare, extension checks, ini values).
- Every settings option with its label, default and effect.
- Every user-visible error/warning string (language files, toast messages).
- Writable paths, caches and log locations.
- Free vs paid gating.
- Third-party compatibility code (grep competitor and framework names).
- The changelog, for recurring bug themes. These become the playbook skeleton.

## Support history (highest value)
- Exported tickets, chat logs, macros/canned replies, internal notes, FAQ drafts.
- Cluster by symptom and count them. The top clusters become §8 headings, in that order.
- Pull exact error strings customers paste, since agents match on them.
- Strip all customer names, emails, domains and credentials before anything
  enters the context file.

## Owner memory and notes
- Developer notes, postmortems, "gotchas" docs and agent memory files often hold
  the silent-failure knowledge that never reached the docs. Mine them, but
  convert them from developer language into support language
  ("symptom → check → fix").
