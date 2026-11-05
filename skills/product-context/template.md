# {{Product}}: Support Context

> **For AI agents only. Not customer-facing.** Read §0 before every conversation.
> Covers: {{version x.y.z, or "continuously deployed service", or model + firmware}} · Last verified: {{YYYY-MM-DD}} · Owner: {{team/role}}
> Status: {{ready | draft: reason}} · Playbook built from: {{tickets | owner answers | docs and forums only}}
> Sources: {{URLs / repo paths / "owner interview" / "owner notes"}}
> Lines marked `(internal)` are for your reasoning only. Never quote them to customers.
> Lines marked `UNVERIFIED:` must be confirmed by a human before you state them as fact.

## Contents
<!-- One line per section, saying when to read it. Agents jump by symptom. -->

---

## 0. Agent rules
<!-- At most 60 lines, bullets only. The only always-relevant part. -->
### Role
<!-- Who you answer, on which channels, and whether you reply directly or draft for a human.
Draft mode: start each draft with a one-line note for the reviewer, and flag `ESCALATE:` when a human must act, not only approve. -->
### Recommended plugins and skills
<!-- One line: "This file is the product knowledge; these plugins are the workflow. Use them together.
Install commands: §16 Setup." Then at most 7 rows: skill | use it for | pairs with §.
Defaults: customer-support:ticket-triage, :draft-response, :customer-escalation, :customer-research,
:kb-article; enterprise-search:search; engineering:debug (software, internal). -->
### Tone & format
### Scope: what we help with / what we don't
<!-- If editions get different support (paid gets email, free or self-hosted gets community only), say how to route each. -->
### Never
<!-- For example: promise features, dates, refunds or replacements; invent facts; ask for passwords
in public channels; quote internal lines; say an action is done when it's only drafted.
Hardware: unsafe repairs, opening sealed parts. -->
### Always collect before debugging
### Escalate to a human when
### When you don't know
<!-- Say so, collect diagnostics, escalate. Never guess a fix that touches data, money or safety. -->

## 1. Product snapshot
<!-- What it is, who it's for, editions, platforms, versions, sister products and things customers confuse. -->

## 2. Plans, pricing & licensing
<!-- See the variants below. -->

## 3. Policies
<!-- Support channels, hours with timezone, SLAs · who gets support by edition · refund and returns policy (quote the policy, not marketing, with source) · billing and invoices. -->

## 4. Requirements & environment
<!-- See the variants below. -->

## 5. Concepts & glossary
<!-- Customer word → product meaning → where it lives. Caches or sync delays: layer | where | how to clear or wait. -->

## 6. Setup, update, removal
<!-- See the variants below. -->

## 7. Features & how-tos
<!-- Feature list per tier · top new-user questions with answers · integrations. -->

## 8. Troubleshooting playbook
<!-- One block per symptom, in the customer's words (from tickets, forums or the owner; inferred symptoms are UNVERIFIED):
### "{{symptom as the customer says it}}"
Likely causes (most likely first) · Checks · Fix · Reply snippet
Include exact error strings. Note silent failures and where the truth hides. -->

## 9. Compatibility
<!-- Third-party product | symptom | workaround | status. Hardware: routers, phones and OS versions, accessories. -->

## 10. Customization
<!-- Supported paths with examples · what's out of support scope. Drop for most hardware. -->

## 11. Diagnostics
<!-- What to ask for · how the customer collects it · logs and debug switches · how to read them. -->

## 12. Escalation & bug reports
<!-- Severity levels · bug report template a developer can act on · where it goes · security reports. Hardware: warranty claim template. -->

## 13. Feature requests & suggestions
<!-- Acknowledge without promising · where to log · roadmap the agent MAY mention · (internal) roadmap it must NOT mention. -->

## 14. Reply templates
<!-- Short canned replies for the most common cases. Adapt, don't paste blindly. -->

## 15. Volatile facts (re-verify on every release)
<!-- As of {{date}}: current version · recent releases · open known issues and workarounds · security advisories · outdated public docs and old docs domains NOT to cite · active promotions. -->

## 16. Links
<!-- Website, pricing, docs, support, refund policy, changelog, status page, downloads. -->

### Setup: plugins for the support agent
<!-- For the humans who install the agent. Keep the commands exact:
Claude Code:
  claude plugin marketplace add anthropics/knowledge-work-plugins
  claude plugin install customer-support@knowledge-work-plugins     # required
  claude plugin install enterprise-search@knowledge-work-plugins    # recommended
  claude plugin install engineering@knowledge-work-plugins          # software teams
(In a session, the same commands start with /plugin.)
Claude.ai or Cowork: Settings → Plugins → add Customer Support, then Enterprise Search.
Connectors and partner plugins: list only the tools the owner uses (e.g. intercom@knowledge-work-plugins).
Last line: load this file as the agent's project or system context. -->

---

# Section variants by product type

Use the column for the product type. For a mix (for example SaaS with a self-hosted
edition), write both and label each block by edition.

| § | Installable software / plugin | SaaS | Hardware / consumer product |
|---|---|---|---|
| 2 | Plans · licence expiry behaviour · activation steps · whether local/staging sites use a slot · licence error → meaning → reply | Plans · usage limits and what counts · overage · trial · plan changes · fees on free tiers | Price per market · subscriptions and what they add · where it's sold (direct vs retailer, and who handles returns for each) |
| 3 | Refund window and exclusions | Refunds, cancellation, data retention after cancel | Returns (opened vs unopened, who pays shipping) · warranty length and what voids it · statutory consumer rights per market |
| 4 | Runtime versions · extensions · server settings table (setting \| minimum \| symptom when too low) · writable paths · hosting, WAF and CSP gotchas | What the customer's site, browser or account needs · status page | **Safety** (heat, power, blades, batteries: what to tell the customer to do now) · power and voltage per market · network needs (2.4/5 GHz, WPA) · phone/OS minimums |
| 6 | Install · large-upload path · update and what it resets · uninstall and what data survives | Sign-up and setup · migration and import · account recovery · data export and deletion | Unboxing and first setup · firmware updates and recovery mode · factory reset and what it erases · spare parts and consumables |
| 11 | System report · logs · debug switches | Account or site IDs · browser console and network tab · API responses | Serial number location · error and LED codes · app logs · photo or video of the fault |
| 12 | Bug-report template | Bug-report template · incident vs bug | Warranty or RMA claim template (serial, proof of purchase, photo or video) |
