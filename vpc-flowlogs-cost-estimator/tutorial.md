# VPC Flow Logs Cost Estimator Tutorial (Agentic)

Estimate the cost of enabling VPC Flow Logs in your project using **Gemini CLI** and the **Google Cloud Network Observability** skill.

**Time to complete**: About 5 minutes

**Prerequisites**:
*   A Google Cloud Platform account and project.
*   Required permissions to view Compute Engine resources and Monitoring metrics.

Click the **Start** (or **Next**) button to move to the next step.

## 1. Select your Project

Ensure you have selected the correct project where you want to estimate the cost.

To set your project in the Cloud Shell terminal, run:

```bash
gcloud config set project <PROJECT_ID>
```

Replace `<PROJECT_ID>` with your actual Google Cloud Project ID.

## 2. Verify and Setup Environment

We will now run a script to verify that your environment is correctly configured and that all required APIs, tools, and skills are available.

Run the verification script:

```bash
./vpc-flowlogs-cost-estimator/verify-env.sh
```

This script will check for `gcloud`, `npx`, `gemini` CLI, ensure the required APIs are enabled, and automatically install the specialized **Google Cloud Network Observability** skill.

## 3. Configure Authentication for Gemini

To allow Gemini CLI to access your Google Cloud project metrics, you need to configure Application Default Credentials (ADC) and set the project ID environment variable.

Run the following commands in your terminal:

```bash
export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value project)
gcloud auth application-default login
```

Follow the prompts in the browser window to authenticate.

## 4. Estimate Cost with Gemini

Now you are ready to ask Gemini for the cost estimation.

Run the Gemini CLI with the cost estimation prompt:

```bash
gemini -p "What is the cost estimation if I enable vpc flowlogs in my project?"
```

Gemini will automatically leverage the installed **Google Cloud Network Observability** skill, query your project's traffic metrics (like GCE network bytes), and provide you with a detailed cost estimation report directly in the terminal!
