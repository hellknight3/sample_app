Feature: creating a patient
  Scenario: when an admin creates a patient
    Given a Admin is logged in
    And they visit a new patient path
    When they submit valid patient information
    Then a patient should be created
    And they should receive a success message
    And a Patient is being logged
    And a log entry with action create should be generated
    And they should have an institution
  
  Scenario Outline: only an admin should be able to create a patient
    Given a <role> is logged in
    When they visit a new patient path
    Then they should receive an error message
    And they should be on their home page
    Examples:
      |role|
      |Director|
      |Doctor|
      |Patient|
