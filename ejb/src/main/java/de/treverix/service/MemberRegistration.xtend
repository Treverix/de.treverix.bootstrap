package de.treverix.service

import de.treverix.model.Member
import javax.ejb.Stateless
import javax.enterprise.event.Event
import javax.inject.Inject
import javax.persistence.EntityManager
import java.util.logging.Logger
import de.treverix.bootstrap.annotation.ConstructorInjection

// The @Stateless annotation eliminates the need for manual transaction demarcation
@Stateless
@ConstructorInjection
class MemberRegistration {

    @Inject Logger log
    @Inject extension EntityManager em
    @Inject Event<Member> memberEventSrc

    def register(Member member) {
        log.info('''Registering «member.name»''')
        persist(member)
        memberEventSrc.fire(member)
    }
}
