Feature: editing an appointment
  Scenario: a doctor edits an appointment
    Given a Doctor is logged in
    And they have an appointment
    And they visit the edit appointments path
    When they submit a change to the appointment
    Then the appointment should be changed
    And a log entry with action update should be generated
    
  Scenario: a doctor edits an appointment incorrectly
    Given a Doctor is logged in
    And they have an appointment
    And they visit the edit appointments path
    When they submit invalid changes to the appointment
    Then they should be on the edit appointments page
    And they should receive an error message
    
  Scenario: a patient should not be able to edit an appointment
    Given a Patient is logged in
    And they have an appointment
    When they visit the edit appointments path
    Then they should get an error message
    And they should be redirected to their current appointments page

  Scenario: a admin should not be able to edit an appointment
    Given a Admin is logged in
    And they have an appointment
    When they visit the edit appointments path
    Then they should get an error message
    And they should be redirected to their current appointments page
