package de.treverix.steps

import cucumber.api.java.Before
import cucumber.api.java.en.Given
import cucumber.api.java.en.When
import cucumber.api.java.en.Then
import cucumber.api.java.en.And
import static org.junit.Assert.*
import de.treverix.support.UserDto
import de.treverix.pages.RegistrationPageModel
import de.treverix.support.SessionContext

class RegistrationStepDefs {

    val extension SessionContext context
    val extension RegistrationPageModel pageModel

    new(SessionContext context, RegistrationPageModel pageModel) {
        this.context = context
        this.pageModel = pageModel
    }

    @Before('@registration')
    def navigateToRegistrationPage() {
        driver.get('http://localhost:8080/bootstrap-web/index.jsf')
    }

    @Given('^a new user "(.*?)"$')
    def aNewUser(String fullName) {
        user = new UserDto => [
            name = fullName
            phoneNumber = '1234512345'
            email = 'any@example.com'
        ]
    }

    @When('^I enter the user details$')
    def whenIEnterTheUserDetails() {
        nameTxtBx.sendKeys(user.name)
        emailTxtBx.sendKeys(user.email)
        phoneTxtBx.sendKeys(user.phoneNumber)
    }

    @And('^I press the submit button$')
    def iPressTheSubmitButton() {
        submitBtn.click
    }

    @Then('^the new user is registered$')
    def theNewUserIsRegistered() {
        assertEquals(2, restUrlLinks.size)
    }
}