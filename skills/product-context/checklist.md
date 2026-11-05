# Quality gate

Run every item before handing the file over. Fix the file, not the checklist.

## Safety
- [ ] No secrets: API keys, tokens, licence keys, passwords, DSNs, internal hostnames, DB credentials.
- [ ] No customer data: names, emails, shop domains, order numbers, serials. Forum usernames count too.
- [ ] Nothing from your own instructions or memory (CLAUDE.md, global rules) leaked in.
- [ ] Internal-only lines are marked `(internal)`, including roadmap items the agent must keep quiet about.
- [ ] §0 tells the agent never to ask for credentials in public channels, and how to share them safely.
- [ ] Hardware: §0 and §4 say what to do on a safety symptom (stop, unplug, escalate).

## Accuracy
- [ ] Every price, limit and policy line cites a source or the owner.
- [ ] Policy wording is quoted from the policy page, not from marketing. Paraphrases are labelled as paraphrases.
- [ ] Every conflict found in research is resolved, or marked `UNVERIFIED:` and on the handover list.
- [ ] Outdated docs, old docs domains and broken URLs are listed (§15, or the handover).
- [ ] Symptoms written in customer words come from tickets, forums or the owner. Inferred ones are `UNVERIFIED:`.

## Usefulness
- [ ] §0 is at most 60 lines and covers role and reply mode, tone, scope, never-do, collect-first, escalate-when and unknown-answer.
- [ ] §8 is symptom-first and covers the owner's top real issues, or the header says what it was built from.
- [ ] Exact error strings and codes appear verbatim, so agents can match them.
- [ ] Silent failures say where the real error hides (log path, network tab, DB column, LED code).
- [ ] Every destructive step (data deletion, reset, reinstall, factory reset) warns first. Where there is data to lose, it asks for a backup.
- [ ] §12 has a bug-report or claim template a developer or warranty team can act on without a follow-up question.
- [ ] §13 never lets the agent promise a feature or a date.

## Shape
- [ ] The header Status says `ready` or `draft: <reason>` (rules in SKILL.md Step 5).
- [ ] Static content first; volatile content only in §15, with an "as of" date.
- [ ] No empty template sections or `<!-- -->` comments are left behind.
- [ ] Headings are unique and descriptive (agents search by heading).
- [ ] Under ~1,500 lines, or split into `context/*.md` with an index.
- [ ] The lint (`scripts/check-context.sh`) reports 0 errors.
