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
        "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q5_K_XL": {
          "name": "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q5_K_XL",
          "limit": {
            "context": 65536,
            "output": 8192
          }
        }
      }
    }
  },
  "model": "leftoverburrito/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q5_K_XL"
}
EOF

echo "opencode installed and configured at $config_file"
