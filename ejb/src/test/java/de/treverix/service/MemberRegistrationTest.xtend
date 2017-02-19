package de.treverix.service

import static extension org.junit.Assert.*
import static extension org.mockito.Mockito.*
import org.junit.runner.RunWith
import org.mockito.junit.MockitoJUnitRunner
import org.mockito.Mock
import java.util.logging.Logger
import javax.persistence.EntityManager
import javax.enterprise.event.Event
import de.treverix.model.Member
import org.mockito.InjectMocks
import org.junit.Test

@RunWith(MockitoJUnitRunner)
class MemberRegistrationTest {

    @Mock Logger log
    @Mock EntityManager em
    @Mock Event<Member> memberEventSrc
    @InjectMocks MemberRegistration victim

    @Test
    def void thatNewMemberIsRegisterdProperly() {
        // Given
        val Member newMember = new Member

        // When
        victim.register(newMember)

        // Then
        log.verify.info(anyString)              // log.info has been called once
        em.verify.persist(newMember)            // em.persist has been called once
        memberEventSrc.verify.fire(newMember)   // memberEventSrc.fire has been called once
    }
}
