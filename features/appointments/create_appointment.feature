Feature: creating an appointment
  @javascript
  Scenario: a doctor creates an appointment 
    Given a Doctor is logged in
    And the doctor visits the new appointments path
    When they submit a valid appointment
    Then an appointment should be created
    And a log entry with action create should be generated
    And they should be on they appointments page
    And atleast one pool should be associated with the appointment

  @javascript
  Scenario: a doctor creates an invalid appointment
    Given a Doctor is logged in
    And the doctor visits the new appointments path
    When they submit an invalid appointment
    Then they should receive an error message
    And they should be on the new appointments page

  Scenario Outline: a patient tries to create an appointment
    Given a <role> is logged in
    When they visit the new appointments path
    Then they should receive an error message
    And they should be redirected to their current appointments page
    Examples:
      |role|
      |Patient|
      |Admin|
      |Director|
