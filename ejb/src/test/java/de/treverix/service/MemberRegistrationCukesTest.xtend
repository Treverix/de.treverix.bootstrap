package de.treverix.service

import cucumber.api.CucumberOptions
import cucumber.api.junit.Cucumber
import org.junit.runner.RunWith

@RunWith(Cucumber)
@CucumberOptions(monochrome=true, format=#["pretty", "html:target/cucumber",
    "rerun:target/rerun.txt"])
class MemberRegistrationCukesTest {
}
