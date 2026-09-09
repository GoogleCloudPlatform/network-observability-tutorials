# VPC Flow Logs Cost Estimator Tutorial (Agentic)

Estimate the cost of enabling VPC Flow Logs in your Google Cloud project using **Antigravity CLI** and the **Google Cloud Network Observability** skill.

**Time to complete**: About 3 minutes

## Run the Cost Estimator

Run the following command in your terminal. This command will verify your environment, install the required skills, and launch Antigravity CLI interactively:

```bash
./vpc-flowlogs-cost-estimator/verify-env.sh && agy -i "Ask me for my Google Cloud Project ID, set it as the active project, and then estimate the cost of enabling VPC Flow Logs." || echo "Verification failed. Please fix the issues and run the command again."
```

During the interactive session, the Antigravity agent will:
1. Ask you to provide your Google Cloud Project ID.
2. Use the installed skill to query traffic metrics and estimate the monthly cost of enabling VPC Flow Logs.
