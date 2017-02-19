package de.treverix.controller

import javax.annotation.PostConstruct
import javax.enterprise.inject.Model
import javax.enterprise.inject.Produces
import javax.faces.application.FacesMessage
import javax.faces.context.FacesContext
import javax.inject.Inject
import javax.inject.Named
import de.treverix.model.Member
import de.treverix.service.MemberRegistration
import de.treverix.bootstrap.annotation.ConstructorInjection

// The @Model stereotype is a convenience mechanism to make this a request-scoped bean that has an
// EL name
// Read more about the @Model stereotype in this FAQ:
// http://www.cdi-spec.org/faq/#accordion6
@Model
@ConstructorInjection
class MemberController {

    @Inject FacesContext facesContext
    @Inject MemberRegistration memberRegistration
    Member newMember

    @Produces @Named
    def getNewMember() {
        return newMember
    }

    def register() {
        try {
            memberRegistration.register(newMember)
            facesContext.addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Registered!", "Registration successful"))
            initNewMember()
        } catch(Exception e) {
            val String errorMessage = getRootErrorMessage(e)
            facesContext.addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, errorMessage, "Registration Unsuccessful"))
        }
    }

    @PostConstruct
    def void initNewMember() {
        newMember = new Member
    }

    def private getRootErrorMessage(Exception e) {
        // Default to general error message that registration failed.
        var String errorMessage = "Registration failed. See server log for more information"
        if(e === null) {
            // This shouldn't happen, but return the default messages
            return errorMessage
        }
        // Start with the exception and recurse to find the root cause
        var Throwable t = e
        while(t !== null) {
            // Get the message from the Throwable class instance
            errorMessage = t.localizedMessage
            t = t.cause
        }
        // This is the root cause message
        return errorMessage
    }
}
