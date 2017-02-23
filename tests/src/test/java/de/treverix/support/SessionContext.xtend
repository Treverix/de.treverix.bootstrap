package de.treverix.support

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SessionContext {
    UserDto user
    SharedDriver driver

    new(SharedDriver driver) {
        this.driver = driver
    }
}

@Accessors
class UserDto {
    String name
    String phoneNumber
    String email
}