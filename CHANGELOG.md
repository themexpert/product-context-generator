# Changelog

## 0.2.2 (2026-11-05)

- Generated files now recommend workflow plugins with exact install commands.
  - §0 has a skills table.
  - §16 has a Setup block.
  - Recommended: Anthropic's Customer Support (required), Enterprise Search, and
    Engineering for software teams, all from `anthropics/knowledge-work-plugins`.
  - Partner plugins and connectors are listed only for tools the owner uses.
- The questionnaire asks which helpdesk, chat and CRM tools the team uses.

## 0.2.1 (2026-11-05)

- Shorter install name: `claude plugin install product-context@themexpert`. The plugin is
  now `product-context`, and the marketplace is `themexpert`. If you installed 0.2.0 or
  earlier, uninstall `product-context-generator@product-context-generator` first.

## 0.2.0 (2026-11-05)

Tested by generating context files for a SaaS product, a WordPress plugin and a hardware
product, and comparing against a run without the skill.

- **New:** product-type variants for SaaS and hardware or consumer products, alongside
  installable software, in the template and the questionnaire.
- **New:** a non-interactive mode. When the owner can't answer, the skill writes a
  `draft` and hands over open questions with recommended defaults.
- **New:** a header `Status: ready | draft` line, plus "Playbook built from", so a thin
  file isn't mistaken for a finished one.
- **New:** a refresh flow for existing files.
- **New:** an eval suite (`claude plugin eval`), lint regression tests, CI, and a plugin icon.
- **Changed:** §0 limit raised to 60 lines, to match its required content.
- **Changed:** source citation for prices and policies.
- **Changed:** the risks-vs-content rule now lets security advisories into §15.
- **Changed:** forum-mining guidance; a fallback when a fetch tool only paraphrases.
- **Changed:** a rule against copying the writer's own instructions or memory into the
  product file.
- **Lint:** moved into the skill folder (`skills/product-context/scripts/`), so it ships
  with skill-only installs.
- **Lint, now catches:** tokens written in prose ("token is …"), licence keys, live/prod
  key prefixes, JWTs, internal hostnames, private IPs, personal-mail customer addresses.
- **Lint, false positives fixed:** `?token=Word` in URLs, `logo@2x.png`, the
  UNVERIFIED legend line, a date deep inside §15.
- **Lint, new checks:** §0 length, Contents, Status, duplicate headings, and
  `<!-- lint-ok -->` for confirmed false positives.

## 0.1.0 (2026-11-04)

- First release: the product-context skill, questionnaire, template, research guide,
  checklist, lint, paste-in prompt and the Acme Forms example.
