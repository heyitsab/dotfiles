---
name: herdr
description: Control Herdr 0.8, a terminal multiplexer for coding agents. Use only when the user explicitly mentions Herdr or asks to inspect or control Herdr panes, tabs, workspaces, worktrees, commands, or agents. Requires HERDR_ENV=1.
---

# Herdr 0.8

Before issuing a control command, verify that the current agent is running in a
Herdr-managed pane:

```bash
test "${HERDR_ENV:-}" = 1
```

If the check fails, say that this session is outside Herdr and stop. Do not
control another focused Herdr session from outside it.

## Learn the installed command surface

The installed binary is authoritative. Use `herdr --help`, then inspect the
relevant command group without probing mutating subcommands:

```bash
herdr agent
herdr pane
herdr workspace
herdr tab
herdr worktree
herdr terminal
herdr notification
herdr integration
herdr session
```

Do not run bare `herdr` for discovery because it launches or attaches the TUI.
Parse IDs from JSON responses instead of predicting them.

## Choose the right primitive

- Workspaces, tabs, and panes organize terminal layout.
- Pane commands control shells, tests, servers, and other ordinary processes.
- Agent commands control a recognized coding agent and understand its
  `idle`, `working`, `blocked`, `done`, and `unknown` states.
- Worktrees isolate branches and file changes for concurrent editing tasks.

Prefer `--current`, an explicit pane ID, or a unique agent name. Do not rely on
the UI-focused pane, which may belong to another client.

## Start and coordinate work

Default to a sibling pane in the current tab and current working directory. Do
not create a workspace, tab, worktree, or different working directory unless
the user explicitly requests that topology.

Inspect the current layout before choosing a split direction:

```bash
herdr pane layout --pane "$HERDR_PANE_ID"
herdr pane split --current --direction right --cwd "$PWD" --no-focus
```

Use `down` instead of `right` for a narrow or tall pane. Read the new pane ID
from `.result.pane.pane_id`.

Start and prompt an agent with a useful unique name:

```bash
herdr agent start reviewer --kind copilot --pane <pane-id>
herdr agent prompt reviewer "Review the current diff." --wait --timeout 120000
```

If an agent blocks or a wait fails, inspect state and output before sending
input:

```bash
herdr agent get reviewer
herdr agent read reviewer --source recent-unwrapped --lines 120
```

Use pane commands for ordinary processes:

```bash
herdr pane run <pane-id> "npm test"
herdr pane wait-output <pane-id> --match "test result" --timeout 120000
herdr pane read <pane-id> --source recent-unwrapped --lines 120
```

## Worktrees

Use a separate worktree when another agent may edit independently:

```bash
herdr worktree create --branch <branch> --base <ref> --no-focus
herdr worktree list
```

Read workspace and path identifiers from the command response. Do not remove a
worktree or workspace that this task did not create unless the user explicitly
asks.

## Safety

- Use `--no-focus` for background work unless the user asks to switch context.
- Never close workspaces, tabs, panes, or sessions you did not create without
  explicit permission.
- Never run `herdr server stop` from an active session unless the user intends
  to stop the server and its pane processes.
- Never kill the main Herdr process.
- Treat `unknown` as unclassified, not as proof that an agent completed.
