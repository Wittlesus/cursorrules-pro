#!/bin/bash
# Setup script for CursorRules Pro starters
# Usage: ./setup.sh <starter-type> <target-directory>
#
# Example: ./setup.sh nextjs-saas /path/to/my-project

set -e

STARTER_TYPE=$1
TARGET_DIR=$2
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

show_usage() {
    echo "CursorRules Pro — Starter Setup Script"
    echo ""
    echo "Usage: ./setup.sh <starter-type> <target-directory>"
    echo ""
    echo "Available starters:"
    echo "  nextjs-saas    Complete Next.js SaaS setup (auth, Stripe, database)"
    echo "  python-api     Python FastAPI/Flask API setup"
    echo "  react-native   React Native / Expo mobile app setup"
    echo "  monorepo       Turborepo/Nx monorepo setup"
    echo ""
    echo "Example:"
    echo "  ./setup.sh nextjs-saas ~/my-saas-project"
    echo ""
}

if [ -z "$STARTER_TYPE" ] || [ -z "$TARGET_DIR" ]; then
    show_usage
    exit 1
fi

# Validate starter type
if [ ! -d "$SCRIPT_DIR/$STARTER_TYPE" ]; then
    print_error "Starter type '$STARTER_TYPE' not found."
    echo ""
    show_usage
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    print_warning "Target directory does not exist. Creating: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

print_info "Setting up $STARTER_TYPE in $TARGET_DIR"
echo ""

# Copy .cursorrules
if [ -f "$SCRIPT_DIR/$STARTER_TYPE/.cursorrules" ]; then
    cp "$SCRIPT_DIR/$STARTER_TYPE/.cursorrules" "$TARGET_DIR/.cursorrules"
    print_success "Copied .cursorrules"
fi

# Copy CLAUDE.md
if [ -f "$SCRIPT_DIR/$STARTER_TYPE/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/$STARTER_TYPE/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
    print_success "Copied CLAUDE.md"
fi

# Copy .vscode settings (if exists)
if [ -d "$SCRIPT_DIR/$STARTER_TYPE/.vscode" ]; then
    mkdir -p "$TARGET_DIR/.vscode"
    cp -r "$SCRIPT_DIR/$STARTER_TYPE/.vscode"/* "$TARGET_DIR/.vscode/"
    print_success "Copied .vscode settings"
fi

# Copy pre-commit hook (if exists)
if [ -f "$SCRIPT_DIR/$STARTER_TYPE/pre-commit" ]; then
    if [ -d "$TARGET_DIR/.git" ]; then
        cp "$SCRIPT_DIR/$STARTER_TYPE/pre-commit" "$TARGET_DIR/.git/hooks/pre-commit"
        chmod +x "$TARGET_DIR/.git/hooks/pre-commit"
        print_success "Installed pre-commit hook (made executable)"
    else
        print_warning "No .git directory found. Pre-commit hook not installed."
        print_info "Copy manually to .git/hooks/pre-commit when you initialize git."
    fi
fi

# Copy Makefile (if exists)
if [ -f "$SCRIPT_DIR/$STARTER_TYPE/Makefile" ]; then
    cp "$SCRIPT_DIR/$STARTER_TYPE/Makefile" "$TARGET_DIR/Makefile"
    print_success "Copied Makefile"
fi

echo ""
print_success "Setup complete!"
echo ""
print_info "Next steps:"

case $STARTER_TYPE in
    nextjs-saas)
        echo "  1. Update CLAUDE.md with your project details"
        echo "  2. Customize .cursorrules with project-specific rules"
        echo "  3. Set up environment variables in .env.local"
        echo "  4. Run: npm install"
        echo "  5. Run: npx prisma migrate dev"
        echo "  6. Start coding with AI assistance!"
        ;;
    python-api)
        echo "  1. Update CLAUDE.md with your project details"
        echo "  2. Customize .cursorrules with project-specific rules"
        echo "  3. Set up environment variables in .env"
        echo "  4. Run: poetry install (or pip install -r requirements.txt)"
        echo "  5. Run: alembic upgrade head"
        echo "  6. Start coding with AI assistance!"
        ;;
    react-native)
        echo "  1. Update CLAUDE.md with your project details"
        echo "  2. Customize .cursorrules with project-specific rules"
        echo "  3. Set up environment variables in .env"
        echo "  4. Run: npm install"
        echo "  5. Run: npx expo start"
        echo "  6. Start coding with AI assistance!"
        ;;
    monorepo)
        echo "  1. Update CLAUDE.md with your monorepo structure"
        echo "  2. Customize .cursorrules for your packages and apps"
        echo "  3. Set up pnpm workspace: pnpm install"
        echo "  4. Configure turbo.json for your pipeline"
        echo "  5. Start coding with AI assistance!"
        ;;
esac

echo ""
print_info "Files installed:"
echo "  - .cursorrules (AI coding rules for your stack)"
echo "  - CLAUDE.md (project context for AI)"
if [ -d "$TARGET_DIR/.vscode" ]; then
    echo "  - .vscode/settings.json (recommended VS Code settings)"
fi
if [ -f "$TARGET_DIR/.git/hooks/pre-commit" ]; then
    echo "  - .git/hooks/pre-commit (AI-assisted code review)"
fi
if [ -f "$TARGET_DIR/Makefile" ]; then
    echo "  - Makefile (common commands with AI context)"
fi

echo ""
print_info "Compatible with: Cursor, Cline, Claude Code, GitHub Copilot, Windsurf"
echo ""
