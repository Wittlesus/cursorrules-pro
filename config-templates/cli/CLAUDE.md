# CLI Tool Project

## Overview
This is a command-line interface (CLI) tool designed for developer productivity, automation, or system administration.

## Tech Stack
**Language**: (Python 3.11+ / Node.js 20+ / Go 1.22+ / Rust)
**CLI Framework**: (Click/Typer / Commander/oclif / Cobra / clap)
**Config**: YAML/JSON/TOML with env var support
**Testing**: pytest / Vitest / Go testing / cargo test
**Distribution**: PyPI / npm / crates.io / GitHub Releases

## Project Structure
```
cli-tool/
  ├── src/           # Source code
  │   ├── commands/  # Command implementations
  │   ├── utils/     # Utilities
  │   └── config/    # Config management
  ├── tests/         # Test files
  ├── docs/          # Documentation
  └── README.md      # User guide
```

## Key Commands
```bash
tool --help              # Show help
tool --version           # Show version
tool init                # Initialize config
tool deploy --env prod   # Deploy to production
tool status              # Check status
tool logs --follow       # Stream logs
```

## Development Rules

### Command Structure
- Use subcommands for actions: `tool <command> [options]`
- Global flags: `--help`, `--version`, `--verbose`, `--config`, `--output`
- Boolean flags: `--force`, `--dry-run`, `--watch`
- Value flags with validation

### User Experience Principles
```
1. Helpful errors with suggestions
2. Progress indicators for long operations
3. Colorized output (green=success, red=error, yellow=warning)
4. Interactive prompts with sensible defaults
5. Confirm destructive actions (unless --force)
```

### Output Formats
```bash
# Human-readable (default)
tool list
# ID    Name       Status
# 1     Project A  Active
# 2     Project B  Paused

# JSON (machine-readable)
tool list --format json
# [{"id":1,"name":"Project A","status":"Active"},...]

# Quiet mode (only essentials)
tool deploy --quiet
# Deployed successfully
```

### Configuration
```yaml
# ~/.config/tool/config.yaml
api_url: https://api.example.com
api_key: ${TOOL_API_KEY}  # From env var
output_format: table
log_level: info
```

Config precedence: CLI flags > env vars > config file > defaults

### Error Handling
```python
# ✅ User-friendly errors
if not api_key:
    console.error("API key not found. Set TOOL_API_KEY or run 'tool login'")
    sys.exit(1)

# ❌ Raw exceptions
raise ValueError("Missing API key")  # Don't do this
```

### Secrets Management
- Load from env vars: `TOOL_API_KEY`, `TOOL_TOKEN`
- Store in OS keychain when possible
- Mask in logs: `Using key sk-***xyz`
- Never log full secrets

### Progress Indicators
```python
# For long operations
from rich.progress import Progress

with Progress() as progress:
    task = progress.add_task("Deploying...", total=100)
    for i in range(100):
        # do work
        progress.update(task, advance=1)
```

### Interactive Prompts
```typescript
import inquirer from 'inquirer';

const { env } = await inquirer.prompt([{
  type: 'list',
  name: 'env',
  message: 'Select environment:',
  choices: ['dev', 'staging', 'prod'],
  default: 'dev'
}]);
```

## Testing CLI Commands

### Integration Tests
```python
# Test command execution
def test_deploy_command():
    result = runner.invoke(cli, ['deploy', '--env', 'dev'])
    assert result.exit_code == 0
    assert 'Deployed successfully' in result.output
```

### Mock External Dependencies
```python
@patch('tool.api.deploy')
def test_deploy_with_api_error(mock_deploy):
    mock_deploy.side_effect = APIError("Network timeout")
    result = runner.invoke(cli, ['deploy'])
    assert result.exit_code == 1
    assert 'Network timeout' in result.output
```

## Common CLI Patterns

### Init Command
```bash
tool init
# Creates config file template at ~/.config/tool/config.yaml
```

### Login Command
```bash
tool login
# Prompt: Enter API key: ****
# Stores securely in OS keychain
```

### List with Pagination
```bash
tool list --page 2 --limit 20
# Shows items 21-40
```

### Watch Mode
```bash
tool logs --follow
# Streams logs in real-time (Ctrl+C to stop)
```

## Distribution

### Python (PyPI)
```bash
pip install cli-tool
# Or for isolated install
pipx install cli-tool
```

### Node.js (npm)
```bash
npm install -g cli-tool
# Or run without install
npx cli-tool
```

### Go (Binaries)
```bash
# Install from GitHub releases
curl -L https://github.com/user/tool/releases/latest/download/tool-linux -o tool
chmod +x tool
```

### Rust (crates.io)
```bash
cargo install cli-tool
# Or with binstall
cargo binstall cli-tool
```

## Exit Codes
- 0: Success
- 1: General error
- 2: Misuse (invalid arguments)
- 130: Interrupted (Ctrl+C)

## Key Reminders for AI Assistants
1. **Helpful errors** — Always suggest next steps
2. **Progress feedback** — Show progress for >2 second operations
3. **Validate inputs** — Check all arguments before execution
4. **Colorized output** — Use colors for readability
5. **Config management** — Support files + env vars
6. **Cross-platform** — Test on Windows, macOS, Linux
7. **Non-zero exit codes** — Exit 1 on errors, 0 on success
8. **Mask secrets** — Never log full API keys/tokens

## Build & Release
```bash
# Build
npm run build      # Creates dist/
# Or
python -m build    # Creates dist/*.whl

# Release
npm publish
# Or
twine upload dist/*
```
