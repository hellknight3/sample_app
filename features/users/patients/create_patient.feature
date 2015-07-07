Feature: creating a patient
  Scenario: when an admin creates a patient
    Given a Admin is logged in
    And they visit a new patient path
    When they submit valid patient information
    Then a patient should be created
    And they should receive a success message
    And a log entry with action create should be generated
  
  Scenario: when a doctor tries to create a patient
    Given a Doctor is logged in
    When they visit a new patient path
    Then they should receive an error message
    And they should be on their home page

  Scenario: when a patient tries to create a patient
    Given a Patient is logged in
    When they visit a new patient path
    Then they should receive an error message
    And they should be on their home page

  Scenario: when a director tries to create a patient
    Given a Director is logged in
    When they visit a new patient path
    Then they should receive an error message
    And they should be on their home page

