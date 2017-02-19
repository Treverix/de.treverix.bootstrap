package de.treverix.data

import javax.annotation.PostConstruct
import javax.enterprise.context.RequestScoped
import javax.enterprise.event.Observes
import javax.enterprise.event.Reception
import javax.enterprise.inject.Produces
import javax.inject.Inject
import javax.inject.Named
import java.util.List
import de.treverix.model.Member
import de.treverix.bootstrap.annotation.ConstructorInjection

@RequestScoped
@ConstructorInjection
class MemberListProducer {

    @Inject MemberRepository memberRepository
    List<Member> members

    // @Named provides access the return value via the EL variable name "members" in the UI (e.g.,
    // Facelets or JSP view)
    @Produces
    @Named
    def getMembers() {
        members
    }

    def onMemberListChanged(@Observes(notifyObserver=Reception.IF_EXISTS) Member member) {
        retrieveAllMembersOrderedByName
    }

    @PostConstruct
    def void retrieveAllMembersOrderedByName() {
        members = memberRepository.findAllOrderedByName
    }
}
