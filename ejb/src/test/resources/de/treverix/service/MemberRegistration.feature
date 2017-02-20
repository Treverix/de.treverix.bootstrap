Feature: Member registration service

  Scenario: User registers a new member
    Given a new member "John Doe"
    When I register the new member
    Then the new member has been persisted
      And a new member event has been fired
