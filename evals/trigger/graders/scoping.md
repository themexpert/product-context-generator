---
type: llm
---
The response asks the owner for scoping information before writing anything. It must ask at least for the product name or description, the sources it may read (website, docs, tickets), and the channels or reply mode.

It passes if these come in one round of questions. It fails if it writes a full context file from nothing, or asks more than about eight questions at once.
