package de.treverix.bootstrap.annotation

import org.eclipse.xtend.core.compiler.batch.XtendCompilerTester
import org.junit.Test

class ConstructorInjectionTest {

    extension XtendCompilerTester compilerTester = XtendCompilerTester.newXtendCompilerTester(ConstructorInjection.classLoader)

    @Test def void testConstructorInjection() {
        '''
        import de.treverix.bootstrap.annotation.ConstructorInjection
        import javax.inject.Inject

        @ConstructorInjection
        class Dummy {
            @Inject Object o1
            @Inject Object o2
        }

        '''.assertCompilesTo(
        '''
        import javax.inject.Inject

        @SuppressWarnings("all")
        public class Dummy {
          private Object o1;

          private Object o2;

          @Inject
          public Dummy(final Object o1, final Object o2) {
            this.o1 = o1;
            this.o2 = o2;
          }
        }
        '''
        )
    }
}