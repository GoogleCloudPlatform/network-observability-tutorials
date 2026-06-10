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

# Verify environment for VPC Flow Logs Cost Estimator tutorial (Skills version).

set -e

echo "Checking environment..."

# 1. Check gcloud
if ! command -v gcloud &> /dev/null; then
    echo "Error: gcloud CLI is not installed. Please run this in Cloud Shell."
    exit 1
fi
echo "✅ gcloud CLI is installed."

PROJECT_ID=$(gcloud config get-value project 2>/dev/null || true)
if [ -n "$PROJECT_ID" ]; then
    echo "✅ Active project: $PROJECT_ID"
fi

# 3. Check Node.js and npx (required for skills CLI)
if ! command -v npx &> /dev/null; then
    echo "Error: npx is not installed. Node.js is required for managing skills."
    exit 1
fi
echo "✅ npx is installed."

# 4. Check Gemini CLI
if ! command -v gemini &> /dev/null; then
    echo "Warning: Gemini CLI ('gemini') is not installed."
    echo "Installing Gemini CLI globally..."
    npm install -g @google/gemini-cli
else
    echo "✅ Gemini CLI is installed."
fi

# 5. Check required APIs
REQUIRED_APIS=(
    "compute.googleapis.com"
    "logging.googleapis.com"
    "monitoring.googleapis.com"
)

if [ -n "$PROJECT_ID" ]; then
    echo "Checking required APIs..."
    ENABLED_APIS=$(gcloud services list --enabled --format="value(config.name)" 2>/dev/null || true)

    if [ -z "$ENABLED_APIS" ]; then
        echo "Warning: Could not retrieve enabled services list. Attempting to verify by enabling..."
        for api in "${REQUIRED_APIS[@]}"; do
            gcloud services enable "$api" --quiet
        done
    else
        for api in "${REQUIRED_APIS[@]}"; do
            if echo "$ENABLED_APIS" | grep -q "^$api$"; then
                echo "  ✅ $api is enabled."
            else
                echo "  ❌ $api is NOT enabled."
                echo "Enabling $api..."
                gcloud services enable "$api" --quiet
            fi
        done
    fi
fi

# 6. Install the Google Cloud Network Observability Skill
echo "Installing Google Cloud Network Observability skill..."
if npx -y skills add google/skills --skill google-cloud-networking-observability -y; then
    echo "  ✅ Google Cloud Network Observability skill is installed."
else
    echo "  ❌ Failed to install Google Cloud Network Observability skill."
    exit 1
fi

echo "Environment verification complete!"

