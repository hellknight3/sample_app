Feature: creating a doctor
    Scenario: when an admin creates a doctor
    Given an Admin is logged in
    And the Admin visits the new doctors path
    When they submit valid doctor information
    Then a doctor should be created
    And they should receive a success message
    And they should be on the user index page Doctors
    And a log entry with the action create should be generated
    And they should have an institution

  Scenario Outline: only an admin should be able to create a doctor
    Given a Director is logged in
    When they visit the new doctors path
    Then they should receive an error message
    And they should be on their homepage
    Examples:
      |role|
      |Director|
      |Patient|
      |Doctor|
