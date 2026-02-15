# CLI Tool Configuration

This directory contains AI coding assistant configurations optimized for building command-line interface (CLI) tools.

## What's Included

| File | For | Description |
|------|-----|-------------|
| `.cursorrules` | Cursor IDE | CLI development rules |
| `CLAUDE.md` | Claude Code CLI | Comprehensive CLI project instructions |
| `.windsurfrules` | Windsurf IDE | Windsurf AI configuration |
| `.github/copilot-instructions.md` | GitHub Copilot | CLI-specific Copilot instructions |

## What This Configuration Covers

### CLI Best Practices
- Subcommand architecture (like git, docker)
- Global flags (--help, --version, --verbose)
- Input validation with helpful errors
- Multiple output formats (table, JSON, YAML)
- Interactive prompts with defaults
- Progress indicators for long operations

### User Experience
- Colorized output (errors, warnings, success)
- Helpful error messages with suggestions
- Confirmation for destructive actions
- Cross-platform compatibility (Windows, macOS, Linux)

### Configuration Management
- Config file support (YAML/JSON/TOML)
- Environment variable support
- Precedence: CLI flags > env vars > config file > defaults

### Supported Languages
- **Python**: Click, Typer, argparse
- **Node.js**: Commander, Yargs, oclif
- **Go**: Cobra, cli package
- **Rust**: clap (derive feature)

## Key Patterns

### Command Structure
```bash
tool [global-flags] <command> [command-flags] [args]

# Examples
tool --version
tool --config custom.yaml deploy --env prod
tool logs --follow --format json
```

### User-Friendly Errors
```
❌ Error: API key not found
💡 Run 'tool login' or set TOOL_API_KEY environment variable
```

### Progress Indicators
```
⠋ Deploying to production...
✓ Deployed successfully in 12.3s
```

### Interactive Prompts
```
? Select environment: (Use arrow keys)
  dev
❯ staging
  production
```

## Common CLI Commands to Implement
- `init` — Initialize config file
- `login` — Authenticate with service
- `deploy` — Deploy/publish
- `status` — Show current state
- `list` — List resources
- `logs` — View or stream logs
- `version` — Show version info
- `help` — Show help

## Exit Codes
- 0: Success
- 1: General error
- 2: Misuse (invalid arguments)
- 130: Interrupted (Ctrl+C)

## Customization

Add your CLI specifics:
```markdown
## Our CLI
- Name: mytool
- Install: npm install -g mytool
- Config: ~/.mytool/config.yaml
- Env vars: MYTOOL_API_KEY, MYTOOL_API_URL
- Log file: ~/.mytool/logs/debug.log
```

## Distribution

### Python (PyPI)
```bash
pip install your-cli
pipx install your-cli  # Isolated install
```

### Node.js (npm)
```bash
npm install -g your-cli
npx your-cli  # Run without install
```

### Go (Binaries)
```bash
go install github.com/user/cli
# Or download from GitHub releases
```

### Rust (crates.io)
```bash
cargo install your-cli
cargo binstall your-cli  # Prebuilt binaries
```

## Examples
- Python: [Rich CLI](https://github.com/Textualize/rich-cli)
- Node.js: [Vercel CLI](https://github.com/vercel/vercel)
- Go: [Hugo](https://github.com/gohugoio/hugo)
- Rust: [ripgrep](https://github.com/BurntSushi/ripgrep)

---

**Built for CLI developers who want polished, user-friendly command-line tools.**
