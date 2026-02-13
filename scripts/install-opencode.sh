#!/usr/bin/env bash
set -euo pipefail

# Install opencode
curl -fsSL https://opencode.ai/install | bash

# Create symlink in ~/.local/bin
ln -sf "$(which opencode)" ~/.local/bin/opencode

# Configure custom provider and model
config_dir="$HOME/.config/opencode"
config_file="$config_dir/opencode.json"

mkdir -p "$config_dir"

cat > "$config_file" << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "leftoverburrito": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "leftoverburrito",
      "options": {
        "baseURL": "http://leftoverburrito.stargazer-darter.ts.net:8080/v1"
      },
      "models": {
        "qwen3-coder-30b-a3b": {
          "name": "Nemotron-3-Nano-30B-A3B",
          "limit": {
            "context": 65536,
            "output": 8192
          }
        }
      }
    }
  },
  "model": "leftoverburrito/Nemotron-3-Nano-30B-A3B"
}
EOF

echo "opencode installed and configured at $config_file"
