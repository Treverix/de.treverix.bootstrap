package de.treverix.rest

import java.util.HashMap
import java.util.HashSet
import java.util.Set
import java.util.logging.Logger
import javax.enterprise.context.RequestScoped
import javax.inject.Inject
import javax.persistence.NoResultException
import javax.validation.ConstraintViolation
import javax.validation.ConstraintViolationException
import javax.validation.ValidationException
import javax.validation.Validator
import javax.ws.rs.Consumes
import javax.ws.rs.GET
import javax.ws.rs.POST
import javax.ws.rs.Path
import javax.ws.rs.PathParam
import javax.ws.rs.Produces
import javax.ws.rs.WebApplicationException
import javax.ws.rs.core.MediaType
import javax.ws.rs.core.Response
import de.treverix.data.MemberRepository
import de.treverix.model.Member
import de.treverix.service.MemberRegistration

/**
 * JAX-RS Example
 * <p/>
 * This class produces a RESTful service to read/write the contents of the members table.
 */
@Path("/members")
@RequestScoped
class MemberResourceRESTService {

    @Inject Logger log
    @Inject Validator validator
    @Inject MemberRepository repository
    @Inject MemberRegistration registration

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    def listAllMembers() {
        return repository.findAllOrderedByName
    }

    @GET
    @Path("/{id:[0-9][0-9]*}")
    @Produces(MediaType.APPLICATION_JSON)
    def lookupMemberById(@PathParam("id") long id) {
        val Member member = repository.findById(id)
        if(member === null) {
            throw new WebApplicationException(Response.Status.NOT_FOUND)
        }
        return member
    }

    /**
     * Creates a new member from the values provided. Performs validation, and will return a JAX-RS response with either 200 ok,
     * or with a map of fields, and related errors.
     */
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    def createMember(Member member) {
        var Response.ResponseBuilder builder = null
        try {
            // Validates member using bean validation
            validateMember(member)
            registration.register(member)
            // Create an "ok" response
            builder = Response.ok
        } catch(ConstraintViolationException ce) {
            // Handle bean validation issues
            builder = createViolationResponse(ce.constraintViolations)
        } catch(ValidationException e) {
            // Handle the unique constrain violation
            var responseObj = #{'email' -> 'Email taken'}
            builder = Response.status(Response.Status.CONFLICT).entity(responseObj)
        } catch(Exception e) {
            // Handle generic exceptions
            var responseObj = #{'error' -> e.message}
            builder = Response.status(Response.Status.BAD_REQUEST).entity(responseObj)
        }

        return builder.build
    }

    /**
     * <p>
     * Validates the given Member variable and throws validation exceptions based on the type of error. If the error is standard
     * bean validation errors then it will throw a ConstraintValidationException with the set of the constraints violated.
     * </p>
     * <p>
     * If the error is caused because an existing member with the same email is registered it throws a regular validation
     * exception so that it can be interpreted separately.
     * </p>
     * @param member Member to be validated
     * @throws ConstraintViolationException If Bean Validation errors exist
     * @throws ValidationException If member with the same email already exists
     */
    def private void validateMember(Member member) {
        // Create a bean validator and check for issues.
        val violations = validator.validate(member)
        if(!violations.isEmpty()) {
            throw new ConstraintViolationException(new HashSet<ConstraintViolation<?>>(violations))
        }
        // Check the uniqueness of the email address
        if(emailAlreadyExists(member.email)) {
            throw new ValidationException("Unique Email Violation")
        }
    }

    /**
     * Creates a JAX-RS "Bad Request" response including a map of all violation fields, and their message. This can then be used
     * by clients to show violations.
     * @param violations A set of violations that needs to be reported
     * @return JAX-RS response containing all violations
     */
    def private Response.ResponseBuilder createViolationResponse(Set<ConstraintViolation<?>> violations) {
        log.fine('''Validation completed. violations found: «violations.size()»''')
        val responseObj = new HashMap
        violations.forEach[
            responseObj.put(propertyPath.toString, message)
        ]
        return Response.status(Response.Status.BAD_REQUEST).entity(responseObj)
    }

    /**
     * Checks if a member with the same email address is already registered. This is the only way to easily capture the
     * "@UniqueConstraint(columnNames = "email")" constraint from the Member class.
     * @param email The email to check
     * @return True if the email already exists, and false otherwise
     */
    def emailAlreadyExists(String email) {
        var Member member = null
        try {
            member = repository.findByEmail(email)
        } catch(NoResultException e) {
            // ignore
        }

        return member !== null
    }
}
