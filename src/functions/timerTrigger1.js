const { app } = require('@azure/functions');
const { chromium, expect } = require('@playwright/test');
const appInsights = require("applicationinsights");
const { v4 } = require('uuid');
var telemetryClient = new appInsights.TelemetryClient(process.env.APPINSIGHTS_INSTRUMENTATIONKEY);
const Stopwatch = require('statman-stopwatch');

async function executeTest(context, myTimer) {

    var timeStamp = new Date().toISOString();
    
    if (myTimer.isPastDue) {
        console.log('JavaScript is running late!');
    }
    console.log('JavaScript timer trigger function ran!', timeStamp);

    // Telemetry data
    var availabilityTelemetry = {
        id: v4(),
        name: process.env.AVAILABILITY_TEST_NAME,
        runLocation: process.env.RUN_LOCATION,
        success: false
    };

    const stopwatch = new Stopwatch();
    const browser = await chromium.launch({ headless: true });

    try {

        //Create playwright flow        
        const page = await browser.newPage();
        stopwatch.start();
        console.log(`Navigating to: ${process.env.WEB_URL}`);
        await page.goto(process.env.WEB_URL);
        var title = await page.title();
        await expect(title).toBe('Bing');
        console.log('Title: ' + title);
        availabilityTelemetry.success = true;

    } catch (error) {
        console.log('Error: ' + error);
        availabilityTelemetry.success = false;
        //Create exception telemetry        
        telemetryClient.trackException({ exception: error });
    } finally {
        stopwatch.stop();
        var elapsed = stopwatch.read();
        console.log('Stopwatch: ' + elapsed);
        availabilityTelemetry.duration = elapsed;
        telemetryClient.trackAvailability(availabilityTelemetry);
        await browser.close();
        // context.done();
    }
}

app.timer('timerTrigger1', {
    schedule: '0 */1 * * * *',
    handler: executeTest
});


