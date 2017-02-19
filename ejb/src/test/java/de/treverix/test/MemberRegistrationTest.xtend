/*
 * JBoss, Home of Professional Open Source
 * Copyright 2014, Red Hat, Inc. and/or its affiliates, and individual
 * contributors by the @authors tag. See the copyright.txt in the
 * distribution for a full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package de.treverix.test

import static extension org.junit.Assert.*
import java.util.logging.Logger
import javax.inject.Inject
import org.jboss.arquillian.container.test.api.Deployment
import org.jboss.arquillian.junit.Arquillian
import de.treverix.model.Member
import de.treverix.service.MemberRegistration
import de.treverix.util.Resources
import org.jboss.shrinkwrap.api.ShrinkWrap
import org.jboss.shrinkwrap.api.asset.EmptyAsset
import org.jboss.shrinkwrap.api.spec.WebArchive
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(Arquillian)
class MemberRegistrationTest {

    @Deployment
    def static createTestArchive() {
        ShrinkWrap.create(WebArchive, 'test.war')
            .addClasses(Member, MemberRegistration, Resources)
            .addAsResource('META-INF/test-persistence.xml', 'META-INF/persistence.xml')
            .addAsWebInfResource(EmptyAsset.INSTANCE, 'beans.xml')
            .addAsWebInfResource('test-ds.xml', 'test-ds.xml')
    }

    @Inject
    extension MemberRegistration memberRegistration

    @Inject
    Logger log

    @Test
    def void testRegister() throws Exception {
        // Given
        val newMember = new Member => [
            name = 'Jane Doe'
            email = 'jane@mailinator.com'
            phoneNumber = '2125551234'
        ]

        // When
        newMember.register

        // Then
        newMember.id.assertNotNull
        log.info('''«newMember.name» was persisted with id «newMember.id»''')
    }
}
