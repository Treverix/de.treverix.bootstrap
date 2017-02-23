package de.treverix.support

import java.io.File
import org.openqa.selenium.firefox.FirefoxDriver
import org.openqa.selenium.htmlunit.HtmlUnitDriver
import org.openqa.selenium.ie.InternetExplorerDriver
import org.openqa.selenium.phantomjs.PhantomJSDriver
import org.openqa.selenium.remote.DesiredCapabilities
import org.openqa.selenium.phantomjs.PhantomJSDriverService
import org.openqa.selenium.Dimension

/**
 * Selenium can use various browsers to run the test. This factory provides a
 * common interface to create them.
 */
class DriverFactory {
    val static String WEBDRIVER_IE_DRIVER_KEY = 'webdriver.ie.driver'

    // sample location for IE Driver server on windows system
    val static String DEFAULT_IE_PATH = 'C:/jenkins/IEDriverServer.exe'

    // sample location for PhantomJS installed with homebrew on MacOS
    val static String DEFAULT_PHANTOM_JS_PATH = '/usr/local/Cellar/phantomjs/2.1.1'

    def static InternetExplorerDriver createIEDriverInstance() {
        var String iePath = System.getProperty(WEBDRIVER_IE_DRIVER_KEY)
        if (iePath === null || iePath.empty) {
            if (new File(DEFAULT_IE_PATH).exists) {
                System.setProperty(WEBDRIVER_IE_DRIVER_KEY, DEFAULT_IE_PATH)
            } else {
                println('Please download the IE driver file first and put it into the folder C:/jenkins.')
                println('Alternatively, you can put the driver file into an arbitrary folder.')
                println('In this case, start the java application with the parameter -Dwebdriver.ie.driver=<qualified file name>.')
            }
        }

        return new InternetExplorerDriver(DesiredCapabilities.internetExplorer => [
            setCapability(InternetExplorerDriver.INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS, true)
            javascriptEnabled = true
        ])
    }

    def static createFirefoxInstance() {
        return new FirefoxDriver
    }

    def static createHtmlUnitInstance() {
        return new HtmlUnitDriver
    }

    def static createPhatomJsDriverInstance() {
        val driver =  new PhantomJSDriver(DesiredCapabilities.phantomjs => [
            setCapability(PhantomJSDriverService.PHANTOMJS_EXECUTABLE_PATH_PROPERTY, DEFAULT_PHANTOM_JS_PATH + '/bin/phantomjs')
            setCapability('takesScreenshot', true)
            javascriptEnabled = true
        ])

        driver.manage.window.size = new Dimension(1024,768)

        return driver
    }
}
