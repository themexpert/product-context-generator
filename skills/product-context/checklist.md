# Quality gate

Run every item before handing the file over. Fix the file, not the checklist.

## Safety
- [ ] No secrets: API keys, tokens, DSNs, passwords, license keys, private hostnames, DB credentials.
- [ ] No customer data: names, emails, domains, order IDs.
- [ ] Internal-only lines are marked `(internal)`.
- [ ] §0 tells the agent never to ask for credentials in public channels, and how to share them safely.

## Accuracy
- [ ] Every price, limit, version and policy has a source or was owner-confirmed.
- [ ] Policy wording is quoted from the policy page, not from marketing copy.
- [ ] Every conflict found in research is resolved or explicitly marked `UNVERIFIED:`.
- [ ] Outdated public docs are listed in §15 as "do not cite".

## Usefulness
- [ ] §0 fits on one screen and covers tone, scope, never-do, collect-first, escalate-when, unknown-answer.
- [ ] §8 is symptom-first, uses the customer's words, and covers the owner's top real issues.
- [ ] Exact error strings appear verbatim, so agents can match them.
- [ ] Silent failures say where the real error hides (log path, network tab, DB column).
- [ ] Every fix states its risk and asks for a backup before anything destructive.
- [ ] §12 has a bug-report template a developer can act on without a follow-up question.
- [ ] §13 never lets the agent promise a feature or date.

## Shape
- [ ] Static content first; volatile content only in §15, with an "as of" date.
- [ ] No empty template sections are left behind.
- [ ] Headings are unique and descriptive (agents search by heading).
- [ ] Under ~1,500 lines, or split into `context/*.md` with an index.
