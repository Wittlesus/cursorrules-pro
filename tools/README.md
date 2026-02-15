# Automation Tools — AI Dev Config Toolkit

**The killer features no free collection has.**

These tools scan your project and automatically generate or convert AI coding configs.

## Tools Included

### 1. `generate-claude-md.sh` — Auto-Generate Project Context

Scans any project and creates a `CLAUDE.md` file with:
- Detected tech stack (Next.js, Python, Rust, Go, etc.)
- Key commands (from package.json, Makefile, etc.)
- Project structure (directory tree)
- Key files (configs, schemas, etc.)

**Usage:**
```bash
./generate-claude-md.sh [target-directory]

# Examples:
./generate-claude-md.sh ~/my-project
./generate-claude-md.sh /var/www/api
./generate-claude-md.sh .  # Current directory
```

**What it detects:**

| File | Detected Stack |
|------|----------------|
| `package.json` with "next" | Next.js |
| `package.json` with "expo" | React Native + Expo |
| `package.json` with "express" | Node.js + Express |
| `requirements.txt` with "fastapi" | Python + FastAPI |
| `requirements.txt` with "django" | Python + Django |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `package.json` with "prisma" | Adds Prisma ORM |
| `package.json` with "tailwindcss" | Adds Tailwind CSS |

**Output:**
```markdown
# Project Name

## Overview
[Add description]

## Tech Stack
- **Framework:** Next.js
- **Language:** TypeScript
- **Database:** Prisma ORM
- **Styling:** Tailwind CSS

## Key Commands
npm run dev           # Start development server
npm run build         # Build for production
npm run test          # Run tests

## Project Structure
[Auto-generated tree]

## Key Files
- `next.config.js` — Next.js configuration
- `prisma/schema.prisma` — Database schema
...
```

**Then:**
1. Review and customize the generated file
2. Add project-specific notes
3. Fill in environment variables
4. Your AI tools now understand your project!

---

### 2. `migrate-cursorrules.sh` — Convert Between Formats

Converts between `.cursorrules` (Cursor/Cline/Windsurf) and `CLAUDE.md` (Claude Code) formats.

**Usage:**
```bash
./migrate-cursorrules.sh <source-file> [output-file]

# Auto-detect output format:
./migrate-cursorrules.sh .cursorrules       # Creates CLAUDE.md
./migrate-cursorrules.sh CLAUDE.md          # Creates .cursorrules

# Specify output:
./migrate-cursorrules.sh .cursorrules CLAUDE.md
./migrate-cursorrules.sh CLAUDE.md .cursorrules
```

**Examples:**

```bash
# Convert Cursor rules to Claude Code format
./migrate-cursorrules.sh .cursorrules CLAUDE.md

# Convert Claude Code format back to Cursor rules
./migrate-cursorrules.sh CLAUDE.md .cursorrules

# Works with any naming:
./migrate-cursorrules.sh .clinerules CLAUDE.md
./migrate-cursorrules.sh .windsurfrules CLAUDE.md
```

**Smart conversion:**
- Detects code blocks in CLAUDE.md and extracts rules
- Wraps plain text rules in code blocks when creating CLAUDE.md
- Preserves formatting and structure
- Shows compatibility info after conversion

**Output:**
```
Converting .cursorrules → CLAUDE.md
✓ Converted to CLAUDE.md format

Migration complete!

File locations:
  Source: .cursorrules
  Output: CLAUDE.md

Tool compatibility:
  ✓ Claude Code (place in project root)
  ✓ GitHub Copilot (copy to .github/copilot-instructions.md)
  • For Cursor: extract rules to .cursorrules
  • For Cline: extract rules to .clinerules
```

---

## Why These Tools Are Valuable

### Time Savings
- **Manual CLAUDE.md creation:** 20-30 minutes
- **With auto-generator:** 10 seconds

### Accuracy
- Detects actual tech stack (no guessing)
- Extracts real commands from your project
- Identifies all key files automatically

### Consistency
- Same format across all projects
- No missing sections
- Standardized structure

### Multi-Tool Support
- Convert once, use everywhere
- No need to maintain separate configs
- Easy switching between AI tools

---

## Advanced Usage

### Generate for Multiple Projects

```bash
# Generate for all projects in a directory
for dir in ~/projects/*; do
  ./generate-claude-md.sh "$dir"
done
```

### Batch Convert

```bash
# Convert all Cursor rules to Claude Code format
find ~/projects -name ".cursorrules" -exec ./migrate-cursorrules.sh {} \;
```

### Custom Templates

Modify the scripts to add your own detection logic:

**Example: Detect custom framework**
```bash
# In generate-claude-md.sh, add to detect_tech_stack():
if grep -q "\"my-framework\"" "$TARGET_DIR/package.json"; then
  stack="$stack- **Framework:** My Framework\n"
fi
```

---

## Requirements

### For `generate-claude-md.sh`:
- Bash (Linux/macOS/Git Bash on Windows)
- `grep` (included on all Unix systems)
- `tree` command (optional, for better structure output)
  - Install on macOS: `brew install tree`
  - Install on Ubuntu/Debian: `apt-get install tree`
  - Install on Windows: `choco install tree` or use Git Bash

### For `migrate-cursorrules.sh`:
- Bash (Linux/macOS/Git Bash on Windows)
- `awk` (included on all Unix systems)

---

## How It Works

### generate-claude-md.sh

1. **Scan project directory** for recognizable files
2. **Detect tech stack** by analyzing:
   - `package.json` dependencies
   - `requirements.txt` or `pyproject.toml`
   - `Cargo.toml` or `go.mod`
3. **Extract commands** from:
   - `package.json` scripts
   - `Makefile` targets with comments
4. **Generate structure** using `tree` command (or fallback)
5. **Identify key files** (configs, schemas, etc.)
6. **Write CLAUDE.md** with all detected info

### migrate-cursorrules.sh

1. **Detect source format** (dotfile vs Markdown)
2. **Auto-detect output** if not specified
3. **Convert content:**
   - To CLAUDE.md: Wrap rules in code block with usage instructions
   - From CLAUDE.md: Extract rules from code blocks (or copy as-is)
4. **Show compatibility** info for different AI tools

---

## Comparison with Manual Setup

| Task | Manual | With Tools |
|------|--------|------------|
| Create CLAUDE.md | 20 min | 10 sec |
| Convert formats | 5 min | 5 sec |
| Detect tech stack | Guess | Accurate |
| Extract commands | Copy-paste | Automatic |
| Update for new project | Recreate | Regenerate |
| Consistency | Varies | Standardized |

---

## Examples

### Real-World Usage

```bash
# New project — auto-generate context
cd my-new-project
/path/to/tools/generate-claude-md.sh .
# Review and customize CLAUDE.md
# Start coding with AI understanding your project

# Switching from Cursor to Claude Code
cd existing-cursor-project
/path/to/tools/migrate-cursorrules.sh .cursorrules CLAUDE.md
# Now works with both tools

# Team uses different AI tools
cd team-project
/path/to/tools/migrate-cursorrules.sh .cursorrules .clinerules
/path/to/tools/migrate-cursorrules.sh .cursorrules CLAUDE.md
cp .cursorrules .windsurfrules
mkdir -p .github && cp .cursorrules .github/copilot-instructions.md
# All team members covered
```

---

## Troubleshooting

**"Command not found: tree"**
- The tool still works, just won't generate pretty directory tree
- Install `tree` for better output (see Requirements above)

**"Permission denied"**
- Make scripts executable: `chmod +x *.sh`

**"No such file or directory"**
- Check file paths are correct
- Use absolute paths if having issues

**Generated CLAUDE.md missing info**
- Review and customize manually
- Add project-specific details
- The tool provides a starting point, not a complete config

---

**These automation tools are exclusive to AI Dev Config Toolkit.**

No free collection offers project scanning or format conversion.
