# Research before you interview

Owners forget what their own website says, and websites forget what the product does
now. Read everything, keep a source next to every fact, and take every disagreement
back to the owner.

## Websites and docs
- Read the product, pricing, support, refund-policy, terms, changelog and docs index pages.
- **Quote policy wording exactly.**
  - Marketing copy ("no questions asked") and the actual policy often differ. Neither
    one wins automatically.
    - The file states the stricter written policy.
    - Cases that fall in the gap go to a human.
    - The gap stays a question for the owner.
  - The same applies when the owner's notes say "actually, we do X" against a public
    page: customers may rely on the public promise. Keep the conflict open and ask the
    owner to fix the page or confirm.
  - If your fetch tool summarizes or truncates pages, get the raw text another way
    (for example `curl -sL <url>`, then strip the HTML).
  - If you can't, label the line `paraphrased from <URL>`, never as a quote.
- **Check each docs article's version.** An article for an old major version that is
  still linked goes in §15 as "do not cite". So do old docs domains that still rank
  in search.
- **Record broken URLs** the owner gave you (404, redirect to the home page) for the
  handover. A URL you only guessed that 404s is not a finding, so drop it.
- **Short on fetches?** Read in this order:
  1. pricing, refund and terms pages;
  2. licensing or account docs;
  3. troubleshooting docs and the changelog;
  4. forum threads, beyond the first ten or so.
- **Check marketplace listings** (app stores, extension directories): status, rating,
  and whether the listing is still published.
- If a fetch returns debug output, errors or a login wall, record it as a risk.
  Don't keep retrying.

## Codebase (if you have it)
Send a subagent with a narrow, fact-finding brief, and ask for a file path with every fact:
- Version numbers and supported platform versions (manifests, package files).
- Install and requirement checks (version_compare, extension checks, ini values).
- Every settings option with its label, default and effect.
- Every user-visible error or warning string (language files, toasts).
- Writable paths, caches and log locations.
- Free vs paid gating.
- Third-party compatibility code (grep for competitor and framework names).
- The changelog, for recurring bug themes. These become the playbook skeleton.

## Support history (highest value)
- **Private history:** exported tickets, chat logs, macros and canned replies,
  internal notes, FAQ drafts.
  - Cluster tickets by symptom and count them. The biggest clusters become §8
    headings, in that order.
  - Copy the exact error strings customers paste, because agents match on them.
- **Public forums and community threads:** useful, but weaker.
  - Read the thread, not just its title. Titles alone give weak clusters.
  - Aim for at least 15–20 threads across the top themes.
  - Many threads marked "resolved" never state the fix. Use a fix only when the
    thread confirms it worked, otherwise mark it `UNVERIFIED:`.
  - A changelog line naming the fix proves a fix shipped, not that it cures the
    customer's symptom. Cite it as "fixed in x.y.z (changelog)", and keep the
    workaround `UNVERIFIED:` unless a thread or the owner confirms it.
  - Summarizing fetch tools add guesses of their own. Keep only causes and fixes the
    thread actually states.
- **Before anything enters the file,** strip customer and forum-user names, emails,
  shop domains, order numbers and credentials. Keep the lesson, not the person.
- When §8 comes only from forums, docs or the changelog, say so in the header's
  "Playbook built from" field.

## Owner memory and notes
- Developer notes, postmortems, "gotchas" docs and agent memory files often hold
  silent-failure knowledge that never reached the docs.
  - Mine them.
  - Convert developer language into support language: symptom → check → fix.
- Pasted owner notes are an owner source, but they are often messy. Watch for:
  - **Secrets:** tokens, keys or admin URLs. Leave them out, and tell the owner to rotate them.
  - **Customer details** in "a ticket I liked". Keep the fix, drop the person.
  - **Conflicts** with the public site. Raise each one with the owner.
  - **Instructions for the bot** ("don't mention X"). These become `(internal)` rules.
