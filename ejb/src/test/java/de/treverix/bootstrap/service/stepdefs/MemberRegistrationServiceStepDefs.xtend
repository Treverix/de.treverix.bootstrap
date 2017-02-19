package de.treverix.bootstrap.service.stepdefs

import cucumber.api.PendingException
import cucumber.api.java.en.Then
import cucumber.api.java.en.When
import de.treverix.model.Member

class MemberRegistrationServiceStepDefs {

    var Member newMember = null


    @When("^I register new member \"([^\"]*)\"$")
    def void iRegisterNewMember(String name) {
        newMember = new Member => [it.name = name]
    }

    @Then("^the new member \"([^\"]*)\" is registered$")
    def void theNewMemberIsRegistered(String name) {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException()
    }
}
