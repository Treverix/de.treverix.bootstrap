package de.treverix.support

import org.openqa.selenium.support.events.EventFiringWebDriver

class SharedDriver extends EventFiringWebDriver {

    val static REAL_DRIVER = DriverFactory.createPhatomJsDriverInstance

    val static Thread CLOSE_THREAD = new Thread {
        override  void run() {
            REAL_DRIVER.close();
        }
    }

    val static int STATIC = {
        Runtime.runtime.addShutdownHook(CLOSE_THREAD)
        return 0
    }

    new() {
        super(REAL_DRIVER)
    }

    override close() {
        if (Thread.currentThread !== CLOSE_THREAD) {
            throw new UnsupportedOperationException("You shouldn't close this WebDriver. It's shared and will close when the JVM exits.")
        }
        super.close;
    }

}