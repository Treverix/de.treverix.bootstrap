@registration
Feature: Registration Page Tests

  Scenario: Register new user
    Given a new user "John Doe"
    When I enter the user details
      And I press the submit button
    Then the new user is registered