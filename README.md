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
    
# How to generate playwright tests

Run the dollowing command within Visual Studio Code terminal to browse specified URL and generate Playwright test code from your interactions with the website.

    npx playwright codegen https://www.bing.com
