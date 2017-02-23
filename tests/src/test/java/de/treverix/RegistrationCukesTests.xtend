package de.treverix

import org.junit.runner.RunWith
import cucumber.api.junit.Cucumber
import cucumber.api.CucumberOptions

@RunWith(Cucumber)
@CucumberOptions(
        plugin = #['pretty', 'html:tests/target/cucumber', 'rerun:tests/target/rerun.txt']
)
class RegistrationCukesTests {
}