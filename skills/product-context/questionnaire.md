# Interview questionnaire

Ask only what research did not answer. Each block names the template section it
feeds. Questions marked ★ matter most for support quality, so never skip them silently.

## A. Identity → §1 Product snapshot
- What is the product, in one sentence a customer would understand?
- Who buys it, and who uses it day to day (often different people)?
- Editions/tiers (free, pro, enterprise) and what separates them. ★
- Platforms and versions supported (CMS, OS, browsers, runtimes). ★
- Current version and release cadence.
- Sister products customers often confuse with this one.

## B. Commercial → §2 Plans & licensing, §3 Policies
- Plans, prices, currency, tax handling, site/seat limits. ★
- What happens when a license expires: does the product keep working, and are updates/support lost? ★
- How activation works: where the key comes from, where it is entered, how many
  activations are allowed, and whether local/staging domains count. ★
- Every license error message and what it actually means. ★
- Refund policy: window, conditions, exclusions, and who approves. ★
- Upgrades, downgrades, transfers, invoices and VAT, and where billing lives.
- Discounts and promotions the agent may mention, and ones it must not.

## C. Support policy → §0 Agent rules, §3 Policies
- Channels, hours (with timezone), response-time promises. ★
- What support covers and what it does not (custom code, third-party conflicts,
  server administration). ★
- Will the agent reply directly or draft for a human? What must always go to a human
  (refunds, legal, security reports, angry customers, data loss)? ★
- May the agent ask for admin or FTP access? How should credentials be shared
  safely, and through which channel? ★
- Tone: formal or friendly? Languages? Sign-off? Words or claims to avoid?
- Free-tier users: same support, limited support, or community only?

## D. Environment → §4 Requirements
- Minimum and recommended runtime versions (PHP/Node/DB/etc.) and required
  extensions or modules. ★
- Server settings that commonly break it (memory, upload size, input vars,
  execution time, WAF/mod_security, CSP, file permissions). ★
- Folders the product must be able to write to. ★
- Hosting types known to cause trouble, and what fixes them.

## E. Concepts → §5 Glossary
- The product's own nouns (what customers see vs. what the code calls them).
- Data model in plain words: where content is stored and what can be exported.
- Caches: every cache layer, where it lives, and how to clear it. ★

## F. Lifecycle → §6 Install, update, uninstall
- Install steps, including the "upload too large" path. ★
- Update steps, and what an update resets or clears.
- Safe uninstall and reinstall: what data survives?
- Migration from old major versions or competitors.

## G. Features → §7 Features & how-tos
- The 10 questions a new user asks in week one, with the answers. ★
- Feature list per tier, plus notable limits.
- Integrations, and how each is enabled.

## H. Troubleshooting → §8 Playbook (the core) ★
- Top 10 real support issues: the customer's exact words, the real cause, how
  you check it, how you fix it. ★
- Exact error messages customers paste, and what each one means. ★
- "Silent" failures: things that fail without an error, and where the truth is
  hidden (logs, network tab, a database column). ★
- Debug-mode switches and log file locations. ★
- What you check first on every ticket.

## I. Compatibility → §9
- Third-party themes, templates, frameworks and plugins with known conflicts,
  the symptom of each, and the workaround. ★
- Optimizers, caches, firewalls and security plugins that interfere.

## J. Customization → §10
- Supported ways to customize (custom CSS/JS fields, overrides, hooks/filters, child themes).
- What is out of scope for support.

## K. Escalation → §12, §13
- Bug-report format the developers want, and where reports go (tracker, email, channel). ★
- Severity levels and their response promises.
- How feature requests are collected, and what the agent may promise (default: nothing). ★
- How to handle security reports. ★

## L. Volatile → §15
- Known open issues and their workarounds right now. ★
- Public docs that are outdated and must not be cited. ★
- Upcoming releases the agent may mention, or must not.
