package de.treverix.bootstrap.annotation

import org.eclipse.xtend.lib.macro.Active
/**
 * Converts field injection to constructur injection. The generated class will have
 * an constructor that takes all fields annotated with @Inject.
 */
@Active(ConstructorInjectionProcessor)
annotation ConstructorInjection {

}