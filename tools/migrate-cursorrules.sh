#!/bin/bash
# Convert .cursorrules to CLAUDE.md format (and vice versa)
# Usage: ./migrate-cursorrules.sh <source-file> [output-file]
#
# Examples:
#   ./migrate-cursorrules.sh .cursorrules CLAUDE.md
#   ./migrate-cursorrules.sh CLAUDE.md .cursorrules
#   ./migrate-cursorrules.sh .cursorrules  # Auto-detects output filename

set -e

SOURCE_FILE=$1
OUTPUT_FILE=$2

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

show_usage() {
    echo "CursorRules Pro — Migration Tool"
    echo ""
    echo "Convert between .cursorrules and CLAUDE.md formats"
    echo ""
    echo "Usage: ./migrate-cursorrules.sh <source-file> [output-file]"
    echo ""
    echo "Examples:"
    echo "  ./migrate-cursorrules.sh .cursorrules CLAUDE.md"
    echo "  ./migrate-cursorrules.sh CLAUDE.md .cursorrules"
    echo "  ./migrate-cursorrules.sh .cursorrules  # Auto-detects output"
    echo ""
}

if [ -z "$SOURCE_FILE" ]; then
    show_usage
    exit 1
fi

if [ ! -f "$SOURCE_FILE" ]; then
    print_error "Source file not found: $SOURCE_FILE"
    exit 1
fi

# Auto-detect output file if not provided
if [ -z "$OUTPUT_FILE" ]; then
    SOURCE_BASENAME=$(basename "$SOURCE_FILE")
    case "$SOURCE_BASENAME" in
        .cursorrules|.clinerules|.windsurfrules)
            OUTPUT_FILE="CLAUDE.md"
            ;;
        CLAUDE.md)
            OUTPUT_FILE=".cursorrules"
            ;;
        *)
            print_error "Cannot auto-detect output format. Please specify output file."
            show_usage
            exit 1
            ;;
    esac
fi

print_info "Converting $SOURCE_FILE → $OUTPUT_FILE"

# Detect conversion direction
SOURCE_BASENAME=$(basename "$SOURCE_FILE")
OUTPUT_BASENAME=$(basename "$OUTPUT_FILE")

if [[ "$OUTPUT_BASENAME" == "CLAUDE.md" ]]; then
    # Converting to CLAUDE.md format
    print_info "Converting to CLAUDE.md format..."

    # CLAUDE.md expects markdown, but rules can be plain text
    # We'll wrap it in a code block for better formatting

    cat > "$OUTPUT_FILE" << 'EOF'
# AI Coding Rules

> These rules guide AI assistants (Cursor, Cline, Claude Code, Copilot) to write better code for this project.

## Rules

```
EOF

    cat "$SOURCE_FILE" >> "$OUTPUT_FILE"

    cat >> "$OUTPUT_FILE" << 'EOF'
```

## Usage

These rules are automatically loaded by:
- **Cursor:** Reads `.cursorrules`
- **Cline:** Reads `.clinerules`
- **Claude Code:** Reads `CLAUDE.md`
- **GitHub Copilot:** Reads `.github/copilot-instructions.md`
- **Windsurf:** Reads `.windsurfrules`

## Customization

Edit these rules to match your team's conventions and coding standards.
EOF

    print_success "Converted to CLAUDE.md format"

elif [[ "$SOURCE_BASENAME" == "CLAUDE.md" ]]; then
    # Converting from CLAUDE.md to .cursorrules
    print_info "Converting to .cursorrules format..."

    # Extract content from CLAUDE.md
    # If it has code blocks, extract from them; otherwise, copy as-is

    if grep -q '```' "$SOURCE_FILE"; then
        # Extract from code blocks
        awk '/```/{flag=!flag;next}flag' "$SOURCE_FILE" > "$OUTPUT_FILE"
        print_info "Extracted rules from code blocks"
    else
        # Copy entire file
        cp "$SOURCE_FILE" "$OUTPUT_FILE"
        print_info "Copied content as-is"
    fi

    print_success "Converted to .cursorrules format"

else
    # Generic conversion (just copy)
    cp "$SOURCE_FILE" "$OUTPUT_FILE"
    print_success "Copied to $OUTPUT_FILE"
fi

echo ""
print_success "Migration complete!"
echo ""
print_info "File locations:"
echo "  Source: $SOURCE_FILE"
echo "  Output: $OUTPUT_FILE"
echo ""

# Show compatibility info
print_info "Tool compatibility:"
if [[ "$OUTPUT_BASENAME" == ".cursorrules" ]]; then
    echo "  ✓ Cursor (place in project root)"
    echo "  • For Cline: rename to .clinerules"
    echo "  • For Windsurf: rename to .windsurfrules"
    echo "  • For Claude Code: convert to CLAUDE.md"
    echo "  • For Copilot: copy to .github/copilot-instructions.md"
elif [[ "$OUTPUT_BASENAME" == "CLAUDE.md" ]]; then
    echo "  ✓ Claude Code (place in project root)"
    echo "  ✓ GitHub Copilot (copy to .github/copilot-instructions.md)"
    echo "  • For Cursor: extract rules to .cursorrules"
    echo "  • For Cline: extract rules to .clinerules"
fi

echo ""
print_info "Pro tip: Use multiple formats for different tools in your team!"
echo "  Example: Keep both .cursorrules (for Cursor) and CLAUDE.md (for Claude Code)"
