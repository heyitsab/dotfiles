#!/usr/bin/env bash

set -euo pipefail

if [[ "${CODESPACES:-false}" != "true" ]]; then
    exit 0
fi

BRAIN_REPO="${COPILOT_BRAIN_REPO:-heyitsab/copilot-brain}"
BRAIN_DIR="${COPILOT_BRAIN_DIR:-$HOME/Documents/Copilot Brain}"
COPILOT_DIR="$HOME/.copilot"
CREDENTIAL_HELPER="$HOME/.local/bin/copilot-brain-git-credential"

mkdir -p "$(dirname "$BRAIN_DIR")" "$COPILOT_DIR" "$(dirname "$CREDENTIAL_HELPER")"

cat > "$CREDENTIAL_HELPER" <<'EOF'
#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${COPILOT_BRAIN_TOKEN:-}" ]]; then
    echo "COPILOT_BRAIN_TOKEN is required to access the private Copilot Brain repository." >&2
    exit 1
fi

GH_TOKEN="$COPILOT_BRAIN_TOKEN" gh auth git-credential "$@"
EOF
chmod 700 "$CREDENTIAL_HELPER"

configure_brain_credentials() {
    git -C "$BRAIN_DIR" config --local credential.helper "!$CREDENTIAL_HELPER"
}

if [[ -d "$BRAIN_DIR/.git" ]]; then
    configure_brain_credentials

    if [[ -n "$(git -C "$BRAIN_DIR" status --porcelain)" ]]; then
        echo "⚠️  Copilot Brain has local changes; skipping automatic pull."
    elif [[ -n "${COPILOT_BRAIN_TOKEN:-}" ]]; then
        echo "🧠 Updating Copilot Brain..."
        git -C "$BRAIN_DIR" pull --ff-only
    else
        echo "⚠️  COPILOT_BRAIN_TOKEN is not set; using the existing Copilot Brain checkout."
    fi
elif [[ -e "$BRAIN_DIR" ]]; then
    echo "⚠️  $BRAIN_DIR exists but is not a Git repository; skipping Copilot Brain setup."
elif [[ -z "${COPILOT_BRAIN_TOKEN:-}" ]]; then
    echo "⚠️  COPILOT_BRAIN_TOKEN is not set; skipping the private Copilot Brain clone."
else
    if ! command -v gh &> /dev/null; then
        echo "⚠️  GitHub CLI is required to clone the private Copilot Brain repository."
    else
        echo "🧠 Cloning Copilot Brain..."
        GH_TOKEN="$COPILOT_BRAIN_TOKEN" gh repo clone "$BRAIN_REPO" "$BRAIN_DIR"
        configure_brain_credentials
    fi
fi

python3 - "$COPILOT_DIR/settings.json" <<'PY'
import json
import os
import sys
from pathlib import Path

path = Path(sys.argv[1])
settings = {}
if path.exists():
    settings = json.loads(path.read_text())

settings.update(
    {
        "contextTier": "default",
        "effortLevel": "high",
        "keepAlive": "busy",
    }
)

temporary_path = path.with_suffix(".tmp")
temporary_path.write_text(json.dumps(settings, indent=2) + os.linesep)
temporary_path.replace(path)
PY

if [[ -d "$BRAIN_DIR" ]]; then
    python3 - "$COPILOT_DIR/mcp-config.json" "$BRAIN_DIR" <<'PY'
import json
import os
import sys
from pathlib import Path

path = Path(sys.argv[1])
brain_dir = sys.argv[2]
config = {}
if path.exists():
    config = json.loads(path.read_text())

servers = config.setdefault("mcpServers", {})
servers["copilot-brain"] = {
    "tools": [
        "read_text_file",
        "read_multiple_files",
        "list_directory",
        "list_directory_with_sizes",
        "search_files",
        "directory_tree",
        "get_file_info",
        "list_allowed_directories",
    ],
    "type": "local",
    "command": "npx",
    "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        brain_dir,
    ],
}

temporary_path = path.with_suffix(".tmp")
temporary_path.write_text(json.dumps(config, indent=2) + os.linesep)
temporary_path.replace(path)
PY
fi

if command -v copilot &> /dev/null; then
    if ! copilot plugin marketplace list 2>/dev/null | grep -q "DietrichGebert/ponytail"; then
        echo "🎠 Adding the Ponytail plugin marketplace..."
        copilot plugin marketplace add DietrichGebert/ponytail
    fi

    if ! copilot plugin list 2>/dev/null | grep -q "ponytail@ponytail"; then
        echo "🎠 Installing the Ponytail plugin..."
        copilot plugin install ponytail@ponytail
    fi
else
    echo "⚠️  Copilot CLI is not installed yet; rerun this script later to install Ponytail."
fi
