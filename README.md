# playwright-on-azure-functions


# Deploy azure services with IaC

Resources needed

1.  Azure function
2.  App service plan
3.  App insights
4.  Log analytics workspace
5.  Storage account

There are terraform / bicep scripts provided in this repository **See links**



# Setup project

1. Install npm packages

    npm install playwright applicationinsights uuid statman-stopwatch

2. Create local.settings.json in root folder of the project

-------
```json
    {
        "IsEncrypted": false,
        "Values": {
            "AzureWebJobsStorage": "<STORAGE_ACCOUNT_CONNECTION_STRING>",
            "FUNCTIONS_WORKER_RUNTIME": "node",
            "AzureWebJobsFeatureFlags": "EnableWorkerIndexing",
            "WEB_URL": "<URL_TO_TEST>",
            "AVAILABILITY_TEST_NAME": "<AVAILABILITY_TEST_NAME>",
            "RUN_LOCATION": "local",
            "APPINSIGHTS_INSTRUMENTATIONKEY": "<APPINSIGHTS_INSTRUMENTATIONKEY>",
            "APPLICATIONINSIGHTS_CONNECTION_STRING": "<APPLICATIONINSIGHTS_CONNECTION_STRING>"
        }
    }
```
# How to generate playwright tests

Run the dollowing command within Visual Studio Code terminal to browse specified URL and generate Playwright test code from your interactions with the website.

    npx playwright codegen https://www.bing.com
