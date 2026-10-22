#!/bin/bash
# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Verify environment for Cloud Network Insights Getting Started tutorial.

set -eo pipefail

echo "Checking environment..."

# 1. Check gcloud
if ! command -v gcloud &> /dev/null; then
    echo "Error: gcloud CLI is not installed. Please run this in Cloud Shell."
    exit 1
fi
echo "✅ gcloud CLI is installed."

# 2. Check Node.js and npx (required for skills CLI)
if ! command -v npx &> /dev/null; then
    echo "Error: npx is not installed. Node.js is required for managing skills."
    exit 1
fi
echo "✅ npx is installed."

# 3. Check Antigravity CLI
export PATH="$HOME/.local/bin:$PATH"
if ! command -v agy &> /dev/null; then
    echo "Warning: Antigravity CLI ('agy') is not installed."
    echo "Installing Antigravity CLI..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
    if ! command -v agy &> /dev/null; then
        echo "Error: Antigravity CLI ('agy') installation failed or binary is not on PATH."
        exit 1
    fi
fi
echo "✅ Antigravity CLI ('agy') is installed."

# 4. Install the Cloud Network Insights Skill
echo "Installing Cloud Network Insights skill..."
if npx -y skills add google/skills --skill cloud-network-insights --agent antigravity -y; then
    echo "  ✅ Cloud Network Insights skill is installed."
else
    echo "  ❌ Failed to install Cloud Network Insights skill."
    exit 1
fi

echo "Environment verification complete!"
