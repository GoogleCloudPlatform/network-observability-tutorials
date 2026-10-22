# Cloud Network Insights Getting Started Tutorial

Set up and verify **Cloud Network Insights** in your Google Cloud project in under 10 minutes using **Antigravity CLI** and the **Cloud Network Insights** skill.

**Time to complete**: About 10 minutes

### Prerequisites

Before starting, ensure you have:
- A Google Cloud project with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project#confirm_billing_is_enabled_on_a_project) (using a dedicated project for Cloud Network Insights is recommended).
- The **Service Usage Admin** (`roles/serviceusage.serviceUsageAdmin`) and **Cloud Network Insights Admin** (`roles/networkmanagement.CloudNetworkInsightsAdmin`) IAM roles on the project, along with permissions to deploy your chosen Monitoring Point (such as Compute Admin for a Compute Engine VM).
- Note that this tutorial provisions billable resources (Cloud Network Insights bills for active paths until disabled, and a `gce-vm` Monitoring Point runs a Compute Engine VM), and first-time enablement requires accepting the Broadcom Terms of Service in the Google Cloud console.

## Run the Onboarding Assistant

Run the following command in your terminal to verify your environment, install the required skill, and launch Antigravity CLI interactively:

```bash
export PATH="$HOME/.local/bin:$PATH"; ./cloud-network-insights-getting-started/verify-env.sh && agy -i "Ask me for my Google Cloud Project ID, set it as the active project, enable the required APIs (networkmanagement.googleapis.com, compute.googleapis.com, logging.googleapis.com, and monitoring.googleapis.com), and then guide me through onboarding to Cloud Network Insights: enable the service, deploy a Monitoring Point, create a starter Network or Web Monitoring Policy, verify the active paths, and share the Google Cloud console link (https://console.cloud.google.com/net-intelligence/cloud-network-insights?project=PROJECT_ID) to view telemetry."
```

**Tip**: By default, `agy` asks for confirmation before running each command. You can change command approval settings at any time by typing `/settings` in the session.

During the interactive session, the Antigravity agent will:
1. Ask for your Google Cloud Project ID, set it as the active project, and enable the required APIs (`networkmanagement.googleapis.com`, `compute.googleapis.com`, `logging.googleapis.com`, and `monitoring.googleapis.com`).
2. Check your Cloud Network Insights provider status (or guide you to enable the `external` provider and accept the Broadcom Terms of Service if needed).
3. Help you deploy and verify a Monitoring Point on your chosen platform (such as a Docker container on a Linux VM, a Compute Engine VM, or a GKE cluster).
4. Create a starter Network or Web Monitoring Policy via the AppNeta API.
5. Verify that your monitored paths are active in Google Cloud and share a direct link to view telemetry in the Google Cloud console.

## Clean up

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

You have onboarded to Cloud Network Insights and verified active synthetic monitoring paths!

If you created resources purely for testing and want to avoid ongoing charges (active paths and any Monitoring Point VMs/workloads continue billing until removed):

1. **Delete deployed Monitoring Points first**: Disabling Cloud Network Insights does not delete your Monitoring Point infrastructure. Delete any Monitoring Points separately (for example, run `terraform destroy` in the Terraform bundle directory for a `gce-vm` Monitoring Point, remove the Docker/Podman container, or run `helm uninstall`).
2. **Disable Cloud Network Insights**: Removing the provider stops active-path billing, removes network paths, web paths, and alert policies, and deprovisions the AppNeta instance. Ask the agent to clean up, or run:

```bash
gcloud network-management network-monitoring-providers delete external --location=global --project=PROJECT_ID
```

Alternatively, open [Cloud Network Insights Settings](https://console.cloud.google.com/net-intelligence/cloud-network-insights/settings) in the Google Cloud console and click **Disable product**.
