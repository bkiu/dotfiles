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
    "chorizoburrito": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "chorizoburrito (3090)",
      "options": {
        "baseURL": "http://chorizoburrito.stargazer-darter.ts.net:8080/v1"
      },
      "models": {
        "gemma4": {
          "name": "gemma4-31b",
          "limit": {
            "context": 262144,
            "output": 32768
          }
        }
      }
    },
    "leftoverburrito": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "leftoverburrito (3060+5060)",
      "options": {
        "baseURL": "http://leftoverburrito.stargazer-darter.ts.net:8080/v1"
      },
      "models": {
        "qwen3.6": {
          "name": "qwen3.6-35b-a3b",
          "limit": {
            "context": 262144,
            "output": 32768
          }
        }
      }
    }
  },
  "model": "chorizoburrito/gemma4",
  "agent": {
    "plan": {
      "model": "leftoverburrito/qwen3.6"
    }
  }
}
EOF

echo "opencode installed and configured at $config_file"
