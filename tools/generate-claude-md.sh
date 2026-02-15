#!/bin/bash
# Auto-generate CLAUDE.md from project structure
# Usage: ./generate-claude-md.sh [target-directory]
#
# This script scans a project and creates a basic CLAUDE.md with:
# - Detected tech stack
# - Project structure
# - Key files
# - Common commands (from package.json, Makefile, etc.)

set -e

TARGET_DIR=${1:-.}
OUTPUT_FILE="$TARGET_DIR/CLAUDE.md"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    print_warning "Directory not found: $TARGET_DIR"
    exit 1
fi

print_info "Scanning project at: $TARGET_DIR"
echo ""

# Detect tech stack
detect_tech_stack() {
    local stack=""

    if [ -f "$TARGET_DIR/package.json" ]; then
        if grep -q "\"next\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Framework:** Next.js\n"
        elif grep -q "\"react\"" "$TARGET_DIR/package.json" && grep -q "\"expo\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Framework:** React Native + Expo\n"
        elif grep -q "\"react\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Framework:** React\n"
        elif grep -q "\"express\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Framework:** Node.js + Express\n"
        fi

        if grep -q "\"typescript\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Language:** TypeScript\n"
        else
            stack="$stack- **Language:** JavaScript\n"
        fi

        if grep -q "\"prisma\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Database:** Prisma ORM\n"
        fi

        if grep -q "\"tailwindcss\"" "$TARGET_DIR/package.json"; then
            stack="$stack- **Styling:** Tailwind CSS\n"
        fi
    fi

    if [ -f "$TARGET_DIR/requirements.txt" ] || [ -f "$TARGET_DIR/pyproject.toml" ]; then
        stack="$stack- **Language:** Python\n"
        if grep -q "fastapi" "$TARGET_DIR/requirements.txt" 2>/dev/null || grep -q "fastapi" "$TARGET_DIR/pyproject.toml" 2>/dev/null; then
            stack="$stack- **Framework:** FastAPI\n"
        elif grep -q "flask" "$TARGET_DIR/requirements.txt" 2>/dev/null; then
            stack="$stack- **Framework:** Flask\n"
        elif grep -q "django" "$TARGET_DIR/requirements.txt" 2>/dev/null; then
            stack="$stack- **Framework:** Django\n"
        fi
    fi

    if [ -f "$TARGET_DIR/Cargo.toml" ]; then
        stack="$stack- **Language:** Rust\n"
    fi

    if [ -f "$TARGET_DIR/go.mod" ]; then
        stack="$stack- **Language:** Go\n"
    fi

    echo -e "$stack"
}

# Extract commands from package.json
extract_npm_commands() {
    if [ -f "$TARGET_DIR/package.json" ]; then
        echo "\`\`\`bash"
        # Extract common scripts
        for script in dev start build test lint type-check; do
            if grep -q "\"$script\":" "$TARGET_DIR/package.json"; then
                desc=$(echo "$script" | sed 's/-/ /g')
                echo "npm run $script           # $(echo ${desc^})"
            fi
        done
        echo "\`\`\`"
    fi
}

# Extract commands from Makefile
extract_make_commands() {
    if [ -f "$TARGET_DIR/Makefile" ]; then
        echo "\`\`\`bash"
        grep "^[a-zA-Z_-]*:.*##" "$TARGET_DIR/Makefile" | while IFS=: read -r target rest; do
            desc=$(echo "$rest" | sed 's/.*## //')
            echo "make $target           # $desc"
        done
        echo "\`\`\`"
    fi
}

# Detect project name
detect_project_name() {
    if [ -f "$TARGET_DIR/package.json" ]; then
        grep -o '"name": *"[^"]*"' "$TARGET_DIR/package.json" | head -1 | sed 's/"name": "\(.*\)"/\1/'
    else
        basename "$TARGET_DIR"
    fi
}

# Generate project structure tree (max 2 levels)
generate_structure() {
    if command -v tree &> /dev/null; then
        tree -L 2 -I 'node_modules|.git|dist|build|.next|__pycache__|venv' "$TARGET_DIR" 2>/dev/null || echo "Unable to generate tree"
    else
        echo "[Install 'tree' command for automatic structure generation]"
    fi
}

# Identify key files
identify_key_files() {
    local files=""

    # Config files
    [ -f "$TARGET_DIR/next.config.js" ] && files="$files- \`next.config.js\` — Next.js configuration\n"
    [ -f "$TARGET_DIR/tsconfig.json" ] && files="$files- \`tsconfig.json\` — TypeScript configuration\n"
    [ -f "$TARGET_DIR/tailwind.config.js" ] && files="$files- \`tailwind.config.js\` — Tailwind CSS configuration\n"

    # Database
    [ -f "$TARGET_DIR/prisma/schema.prisma" ] && files="$files- \`prisma/schema.prisma\` — Database schema\n"

    # Python
    [ -f "$TARGET_DIR/requirements.txt" ] && files="$files- \`requirements.txt\` — Python dependencies\n"
    [ -f "$TARGET_DIR/pyproject.toml" ] && files="$files- \`pyproject.toml\` — Python project configuration\n"

    # Rust
    [ -f "$TARGET_DIR/Cargo.toml" ] && files="$files- \`Cargo.toml\` — Rust dependencies\n"

    # Go
    [ -f "$TARGET_DIR/go.mod" ] && files="$files- \`go.mod\` — Go module definition\n"

    echo -e "$files"
}

# Generate CLAUDE.md content
PROJECT_NAME=$(detect_project_name)
TECH_STACK=$(detect_tech_stack)
KEY_COMMANDS=$(extract_npm_commands)
if [ -z "$KEY_COMMANDS" ]; then
    KEY_COMMANDS=$(extract_make_commands)
fi
PROJECT_STRUCTURE=$(generate_structure)
KEY_FILES=$(identify_key_files)

# Write to file
cat > "$OUTPUT_FILE" << EOF
# $PROJECT_NAME

## Overview
[Add a brief description of what this project does]

## Tech Stack
$TECH_STACK

## Key Commands
$KEY_COMMANDS

## Project Structure
\`\`\`
$PROJECT_STRUCTURE
\`\`\`

## Key Files
$KEY_FILES

## Environment Variables
\`\`\`bash
# Add your environment variables here
# Example:
# DATABASE_URL=postgresql://...
# API_KEY=...
\`\`\`

## Getting Started
1. Install dependencies
2. Set up environment variables (copy .env.example to .env)
3. Run database migrations (if applicable)
4. Start development server

## Notes
[Add project-specific notes, conventions, and important information here]
EOF

print_success "Generated CLAUDE.md at: $OUTPUT_FILE"
echo ""
print_info "Next steps:"
echo "  1. Review and customize CLAUDE.md with project-specific details"
echo "  2. Add environment variables, database schema notes, etc."
echo "  3. Document architectural decisions and conventions"
echo ""
print_info "This file helps AI assistants understand your project structure and provide better suggestions."
