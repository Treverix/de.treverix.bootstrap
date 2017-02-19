package de.treverix.data

import javax.enterprise.context.ApplicationScoped
import javax.inject.Inject
import javax.persistence.EntityManager
import de.treverix.model.Member
import de.treverix.bootstrap.annotation.ConstructorInjection

@ApplicationScoped
@ConstructorInjection
class MemberRepository {

    @Inject extension EntityManager em

    def findById(Long id) {
        return Member.find(id)
    }

    def findByEmail(String email) {
        val cb = criteriaBuilder
        val criteria = cb.createQuery(Member)
        val member = criteria.from(Member)
        criteria.select(member).where(cb.equal(member.get("email"), email))
        return criteria.createQuery.singleResult
    }

    def findAllOrderedByName() {
        val cb = criteriaBuilder
        val criteria = cb.createQuery(Member)
        val member = criteria.from(Member)
        criteria.select(member).orderBy(cb.asc(member.get("name")))
        return criteria.createQuery.resultList
    }
}
