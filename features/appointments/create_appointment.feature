Feature: creating an appointment
  Scenario: a doctor creates an appointment 
    Given a Doctor is logged in
    And the doctor visits the new appointments path
    When they submit a valid appointment
    Then an appointment should be created
    And a log entry with action create should be generated
    And atleast one pool should be associated with the appointment

  Scenario: a doctor creates an invalid appointment
    Given a Doctor is logged in
    And the doctor visits the new appointments path
    When they submit an invalid appointment
    Then they should receive an error message
    And they should be on the new appointments page

  Scenario: a patient tries to create an appointment
    Given a Patient is logged in
    When the patient visits the new appointments path
    Then they should receive an error message
    And they should be redirected to their current appointments page

  Scenario: an admin tries to create an appointment
    Given an Admin is logged in
    When the admin visits the new appointments path
    Then they should receive an error message
    And they should be redirected to their current appointments page
