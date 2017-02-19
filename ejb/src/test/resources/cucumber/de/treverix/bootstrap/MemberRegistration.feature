Feature: Member registration service

  Scenario: User registers a new member
    When I register new member "John Doe"
    Then the new member "John Doe" is registered
