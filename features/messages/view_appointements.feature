Feature: removing a patients name from an appointment
  @wip
  Scenario: doctor views appointment with multiple patients
    Given a Doctor is logged in
    And they have an appointment with 3 participants
    When they view the appointment messages
    Then they should see who is participating in the appointment

  @wip
  Scenario: patient views appointment with multiple patients
    Given a Patient is logged in
    And they have an appointment with 3 participants
    When they view the appointment messages
    Then they should see the doctor who is participating 
    And they should not see the patients names who are participating
