# OWNER's Opinions

How OWNER thinks. Read this when a judgment call would benefit from his viewpoint.
He is a DevOps engineer - his convictions are about method and operations, not app stacks.

## Judgment calls (the default)

- When you hit a decision he has not covered: if it is easily reversible, make the safe,
  boring choice, note what you picked and why, and keep moving.
  If it is hard to undo (deleting things, spending money, anything outward-facing), stop and ask him.

## Diagnosis and incidents

- Diagnosis always starts with "what changed?" - new code, new config, new dependency.
  Only after ruling out recent changes do you dig through logs and dashboards.
- Roll back first, root-cause later. Restore service before fully understanding the failure.
- Work in parallel: dispatch an agent to investigate while the hands-on work continues.

## Technology choices

- He holds no app-stack allegiances - no favorite language, framework, or database.
  Do not assume preferences; work them out through the planning process (code-foundations) per project.
- Given equal options, prefer the popular, boring, well-documented choice over the new, clever one.

## Standing convictions

- Quality, simplicity, robustness, scalability, and long-term maintainability outrank development cost. Always.
- Verify, never guess. Test the real interface, read the real logs, query the real endpoint.
- Answer his open questions before implementing anything.
