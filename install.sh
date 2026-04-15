#!/bin/zsh
# install.sh — PDF 2 PNG Quick Action installer for macOS

set -e

echo ""
echo "=== PDF 2 PNG Installer ==="
echo ""

# ── 1. Check macOS ──────────────────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  echo "❌ This tool is macOS only."
  exit 1
fi

# ── 2. Check / install Homebrew ─────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "🍺 Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew found: $(brew --version | head -1)"
fi

# ── 3. Install Ghostscript ───────────────────────────────────────────────────
GS_CMD="/opt/homebrew/bin/gs"
if [ ! -x "$GS_CMD" ]; then
  GS_CMD="/usr/local/bin/gs"
fi

if [ ! -x "$GS_CMD" ]; then
  echo "👻 Installing Ghostscript..."
  brew install ghostscript
  # 重新偵測路徑
  GS_CMD="/opt/homebrew/bin/gs"
  [ ! -x "$GS_CMD" ] && GS_CMD="/usr/local/bin/gs"
else
  echo "✅ Ghostscript found: $($GS_CMD --version)"
fi

# ── 4. Print next steps ──────────────────────────────────────────────────────
echo ""
echo "✅ Dependencies installed!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Next: Add the Quick Action in Shortcuts.app"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Open Shortcuts.app"
echo "2. Click + → new shortcut"
echo "3. Click ⓘ (top right) → check 'Finder' under Quick Actions"
echo "4. Search 'Run Shell Script' → add it"
echo "5. Shell = zsh | Pass input = as arguments"
echo "6. Paste the following script:"
echo ""
echo "────────────────────────────────────────────────"
cat "$(dirname "$0")/shortcut-script.sh"
echo "────────────────────────────────────────────────"
echo ""
echo "7. Name the shortcut: PDF 2 PNG"
echo "8. Close — it auto-saves."
echo ""
echo "Done! Right-click any PDF in Finder → Quick Actions → PDF 2 PNG"
echo ""
