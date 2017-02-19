package de.treverix.bootstrap.annotation

import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.TransformationContext
import java.util.ArrayList
import javax.inject.Inject
import org.eclipse.xtend.lib.macro.declaration.MutableFieldDeclaration
import org.eclipse.xtend.lib.macro.declaration.Visibility

class ConstructorInjectionProcessor extends AbstractClassProcessor {

    override doTransform(MutableClassDeclaration annotatedClass, extension TransformationContext context) {

        // remove the active annotation, not needed anymore
        val activeAnnotation = annotatedClass.findAnnotation(ConstructorInjection.newTypeReference.type)
        annotatedClass.removeAnnotation(activeAnnotation)

        // collect all @Inject annotated fields and remove the annotation
        val injectFields = new ArrayList<MutableFieldDeclaration>
        for (field : annotatedClass.declaredFields) {
            val indexAnnotation = field.findAnnotation(Inject.newTypeReference.type)
            if (indexAnnotation !== null) {
                field.removeAnnotation(indexAnnotation)
                injectFields.add(field)
            }
        }

        // create a no args constructor, required for EJB spec
        annotatedClass.addConstructor [
            visibility = Visibility.PUBLIC
            body = ['''
                «FOR field : injectFields»
                this.«field.simpleName» = null;
                «ENDFOR»
                '''
            ]
        ]

        // create a new constructor with all collected fields
        annotatedClass.addConstructor [
            visibility = Visibility.PUBLIC

            // annotate new constructor with @Inject
            addAnnotation(Inject.newAnnotationReference)

            // add parameters based on @Inject annotated fields
            for (field : injectFields) {
                addParameter(field.simpleName, field.type)
            }

            // create constructor body
            body = ['''
                «FOR field : injectFields»
                this.«field.simpleName» = «field.simpleName»;
                «ENDFOR»
                '''
            ]
        ]
    }
}