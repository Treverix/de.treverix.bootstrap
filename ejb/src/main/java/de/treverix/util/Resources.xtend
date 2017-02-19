package de.treverix.util

import java.util.logging.Logger
import javax.enterprise.inject.Produces
import javax.enterprise.inject.spi.InjectionPoint
import javax.persistence.EntityManager
import javax.persistence.PersistenceContext

/**
 * This class uses CDI to alias Java EE resources, such as the persistence context, to CDI beans
 * <p>
 * Example injection on a managed bean field:
 * </p>
 * <pre>
 * &#064;Inject
 * private EntityManager em;
 * </pre>
 */
class Resources {

    @Produces
    @PersistenceContext
    EntityManager em

    @Produces
    def produceLog(InjectionPoint injectionPoint) {
        return Logger.getLogger(injectionPoint.member.declaringClass.name)
    }
}
