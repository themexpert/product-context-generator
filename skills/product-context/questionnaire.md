# Interview questionnaire

Ask only what research didn't answer. Each block names the section it feeds.
Never skip a question marked ★ silently. In a non-interactive run, put any
unanswered ★ question on the handover list.

Use the common blocks, then the block for each product type: S (installable
software), C (SaaS), H (hardware).

## Common

### A. Identity → §1
- What is the product, in one sentence a customer would understand?
- Who buys it, and who uses it day to day? They are often different people.
- Editions or tiers, and what separates them. ★
- Does each edition get the same support? Are some community-only, such as free or
  self-hosted? ★
- Current version or model, and release cadence.
- Sister products, old products or discontinued accessories customers confuse with this one.

### B. Commercial → §2, §3
- Plans, prices, currency, tax handling, and seat, site or usage limits. ★
- Refund or returns policy: window, conditions, exclusions, who approves it. ★
- Upgrades, downgrades, transfers, invoices and VAT, and where billing lives.
- Promotions or coupons the agent may mention, and ones it must not.

### C. Support policy → §0, §3
- Channels, hours with timezone, and response-time promises. ★
- What support covers and what it doesn't. ★
- Does the agent reply directly or draft for a human? What must always go to a
  human? (Refunds, legal, security, safety, angry customers, data loss.) ★
- May the agent ask for access (admin login, dashboard invite, device serial)? Through
  which channel is that safe? ★
- Tone, languages, sign-off, and words or claims to avoid.
- Which helpdesk, chat, CRM and docs tools does the team use (Intercom, Zendesk, HubSpot,
  Slack, Gmail, Notion, Jira)? This picks the plugins and connectors in §0 and §16.

### D. Concepts → §5
- The product's own nouns: what customers see vs what the team calls them.
- Where customer data lives, and what can be exported.
- Anything that delays or caches changes (caches, sync intervals, processing time),
  and how to clear it or how long to wait. ★

### E. Troubleshooting → §8 (the core) ★
- Top 10 real support issues: the customer's exact words, the real cause, how you
  check it, how you fix it. ★
- Exact error messages, codes or LED patterns customers report, and what each means. ★
- Silent failures: things that fail without an error, and where the truth is hidden. ★
- What you check first on every ticket.

### F. Compatibility → §9
- Third-party products with known conflicts, the symptom of each, and the workaround. ★

### G. Escalation → §12, §13
- The bug-report or claim format the team wants, and where it goes. ★
- Severity levels and the response promise for each.
- How feature requests are collected. What may the agent promise? (Default: nothing.) ★
- Roadmap items the agent may mention, and ones it must keep quiet about.
- How to handle security reports. ★

### H. Volatile → §15
- Known open issues and their workarounds right now. ★
- Public docs, help articles or old docs sites that are outdated and must not be cited. ★
- Upcoming releases the agent may mention, or must not.

## S. Installable software or plugin
- What happens when a licence expires? Does the product keep working, and are updates
  or support lost? ★
- How does activation work? Where does the key come from and where is it entered? How
  many activations are allowed, and do local or staging sites count? ★
- Every licence error message, and what it actually means. ★
- Minimum and recommended runtime versions, and required extensions. ★
- Server settings that commonly break it: memory, upload size, input vars,
  execution time, WAF or mod_security, CSP, file permissions. ★
- Folders it must be able to write to. ★
- Install steps, including the path for when the upload is too large. ★
- What an update resets. What data survives an uninstall? ★
- Debug switches and log locations. ★
- Supported customization (CSS/JS fields, overrides, hooks), and what's out of scope.

## C. SaaS
- Usage limits: what counts, what happens at the limit, overage, and the trial. ★
- Data retention after a trial ends, after cancellation, and after account deletion. ★
- How a customer exports their data, and how they delete their account.
- Account recovery: a lost owner, a lost 2FA device, a team member who left. ★
- Status page URL, and how incidents are told to customers. ★
- What IDs or links let support see the problem without a password (site ID, share
  link, guest invite)? ★
- Regions, data residency, and compliance claims the agent may repeat.

## H. Hardware or consumer product
- **Safety:** symptoms that mean "stop using it now" (heat, smell, smoke, shock, battery
  swelling), and what the agent tells the customer. ★
- Warranty length, what voids it, and how a claim works (serial number location, proof
  of purchase, photo or video). ★
- Returns: opened vs unopened, who pays shipping, and retailer vs direct purchase. ★
- Markets sold in: voltage, plugs, prices and currency, and statutory rights that
  override your policy. ★
- What's in the box, the first-setup steps, and minimum phone or OS versions. ★
- Firmware updates, recovery mode, and factory reset: what each one erases. ★
- Error codes, LED patterns, and what each means. ★
- Spare parts and consumables: what customers may replace themselves, prices, how
  often, and where to buy them.
