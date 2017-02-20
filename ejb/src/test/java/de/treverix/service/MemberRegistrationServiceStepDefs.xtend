package de.treverix.service

import cucumber.api.PendingException
import cucumber.api.java.en.Then
import cucumber.api.java.en.When
import de.treverix.model.Member
import de.treverix.service.MemberRegistration
import cucumber.api.java.en.Given
import cucumber.api.java.Before
import org.mockito.Mock
import java.util.logging.Logger
import javax.persistence.EntityManager
import javax.enterprise.event.Event
import static extension org.mockito.Mockito.*
import org.mockito.MockitoAnnotations

class MemberRegistrationServiceStepDefs {

    @Mock Logger log
    @Mock EntityManager em
    @Mock Event<Member> eventMemberService

    var Member newMember = null
    var MemberRegistration victim

    @Before
    def beforeScenario() {
        MockitoAnnotations.initMocks(this)
        victim = new MemberRegistration(log, em, eventMemberService)
    }

    @Given('^a new member "([^\"]*)"$')
    def void aNewMember(String name) {
        newMember = new Member => [it.name = name]
    }

    @When("^I register the new member$")
    def void iRegisterTheNewMember() {
        victim.register(newMember)
    }

    @Then("^the new member has been persisted$")
    def void theNewMemberHasBeenPersisted() {
        em.verify.persist(newMember)
    }

    @Then("^a new member event has been fired$")
    def void aNewMemberEventHasBeenFired() {
        eventMemberService.verify.fire(newMember)
    }
}
