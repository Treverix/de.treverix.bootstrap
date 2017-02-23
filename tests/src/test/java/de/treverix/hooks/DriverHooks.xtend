package de.treverix.hooks

import cucumber.api.Scenario
import cucumber.api.java.Before
import cucumber.api.java.After
import org.openqa.selenium.OutputType
import de.treverix.support.SharedDriver

class DriverHooks {

    val extension SharedDriver driver

    new(SharedDriver driver) {
        this.driver = driver
    }

    @Before
    def deleteAllCookies() {
        println('delete cookies')
        manage.deleteAllCookies
    }

    @After
    def embedScreenshot(Scenario scenario) {
        try {
            val screenshot = getScreenshotAs(OutputType.BYTES);
            scenario.embed(screenshot, "image/png");
        } catch(Exception somePlatformsDontSupportScreenshots) {
            println(somePlatformsDontSupportScreenshots.message);
        }
    }
}