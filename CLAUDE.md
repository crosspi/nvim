# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a **LazyVim overlay configuration** — it layers customizations on top of the LazyVim distribution, not a standalone Neovim config. LazyVim provides the base plugin set (~30 plugins), default keymaps, default options, and default autocommands. Every file in this repo either overrides a LazyVim default or adds a new plugin.

**Entry point:** `init.lua` (3 lines) bootstraps lazy.nvim, then hands off to `lua/config/lazy.lua`.

```
init.lua → require("config.lazy") → lazy.setup() imports:
  1. LazyVim/LazyVim (import = "lazyvim.plugins")  — base distribution
  2. import = "plugins"                              — user overrides/additions
```

## Module organization

Each concern lives in its own file under `lua/`:

| File | Role |
|------|------|
| `lua/config/lazy.lua` | lazy.nvim bootstrap + setup (spec, defaults, checker, performance) |
| `lua/config/options.lua` | `vim.opt`/`vim.g` overrides — platform-aware |
| `lua/config/keymaps.lua` | Custom keymaps layered on top of LazyVim defaults |
| `lua/config/autocmds.lua` | Custom autocommands (parent dirs, trim whitespace, bigfile perf) |
| `lua/plugins/*.lua` | Plugin specs — each file returns a table (or list of tables) |

## Plugin spec pattern

All files in `lua/plugins/` return a lazy.nvim spec table. To override a LazyVim-included plugin, use the same plugin name and provide an `opts` key. To add a new plugin, define the full spec. Plugins default to `lazy = true` (set globally in `lazy.lua`).

## Formatting

Use **StyLua** (`stylua.toml` — 2-space indent, 120-column width):
```
stylua lua/
```

## LazyVim extras

Enabled in `lazyvim.json`: Rust, JSON, TOML, Nix, Markdown, and mini.files. These import pre-packaged plugin groups from LazyVim.

## Platform awareness

`options.lua` and `autocmds.lua` branch on `os.getenv("TERMUX_VERSION")` for mobile vs. desktop. Desktop further branches on `vim.g.neovide` (GUI) and `vim.fn.has("wsl")` (clipboard via Windows). When editing config files, preserve all platform branches — do not simplify them into a single path.

## Key custom plugins

- **opencode.nvim** — AI coding assistant (keybinds: `<C-a>` ask, `<C-x>` execute, `<C-.>` toggle, `go` operator)
- **gemini.nvim + mcp.nvim** — Gemini CLI integration with MCP protocol
- **kulala.nvim** — HTTP client for `.http`/`.rest` files (keybinds: `<leader>Rs`/`Ra`/`Rb`, `[R`/`]R`)
- **colorscheme** — tokyonight (moon, transparent) and catppuccin (transparent)
- **treesitter** — extended `ensure_installed` list
- **flash.nvim** — labels enabled in search and char modes
